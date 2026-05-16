$ErrorActionPreference = 'Stop'

function Escape-XmlText {
    param([string]$Text)
    if ($null -eq $Text) { return '' }
    return [System.Security.SecurityElement]::Escape($Text)
}

function Read-LinesUtf8 {
    param([string]$Path)
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    $text = $text -replace "`r`n", "`n"
    return $text -split "`n"
}

function New-RunXml {
    param(
        [string]$Text,
        [switch]$Bold,
        [switch]$Italic
    )
    $rPr = @()
    if ($Bold) { $rPr += '<w:b/>' }
    if ($Italic) { $rPr += '<w:i/>' }
    $rPr += '<w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman" w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    $rPr += '<w:sz w:val="26"/><w:szCs w:val="26"/>'
    $escaped = Escape-XmlText $Text
    return "<w:r><w:rPr>$($rPr -join '')</w:rPr><w:t xml:space=`"preserve`">$escaped</w:t></w:r>"
}

function New-ParagraphXml {
    param(
        [string]$Text = '',
        [string]$Style = 'Normal',
        [string]$Justification = 'both',
        [switch]$Bold,
        [switch]$Italic,
        [switch]$PageBreakBefore,
        [switch]$KeepWithNext
    )
    $pPr = @("<w:pStyle w:val=`"$Style`"/>")
    $pPr += "<w:jc w:val=`"$Justification`"/>"
    $pPr += '<w:spacing w:line="288" w:lineRule="auto" w:before="0" w:after="120"/>'
    if ($PageBreakBefore) { $pPr += '<w:pageBreakBefore/>' }
    if ($KeepWithNext) { $pPr += '<w:keepNext/>' }
    $runs = if ([string]::IsNullOrEmpty($Text)) { '<w:r/>' } else { New-RunXml -Text $Text -Bold:$Bold -Italic:$Italic }
    return "<w:p><w:pPr>$($pPr -join '')</w:pPr>$runs</w:p>"
}

function New-PageBreakXml {
    return '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'
}

function New-FieldSectionXml {
    param(
        [string]$Title,
        [string]$Instruction
    )
    $list = New-Object System.Collections.Generic.List[string]
    $list.Add((New-ParagraphXml -Text $Title -Style 'Heading1' -Justification 'left' -KeepWithNext))
    $list.Add(@"
<w:p>
  <w:pPr>
    <w:pStyle w:val="Normal"/>
    <w:jc w:val="left"/>
    <w:spacing w:line="288" w:lineRule="auto" w:before="0" w:after="120"/>
  </w:pPr>
  <w:r><w:fldChar w:fldCharType="begin"/></w:r>
  <w:r><w:instrText xml:space="preserve">$Instruction</w:instrText></w:r>
  <w:r><w:fldChar w:fldCharType="separate"/></w:r>
  <w:r><w:t>Right-click to update field.</w:t></w:r>
  <w:r><w:fldChar w:fldCharType="end"/></w:r>
</w:p>
"@)
    return $list
}

function New-CaptionParagraphXml {
    param(
        [string]$Label,
        [int]$Number,
        [string]$Text
    )
    $escapedText = Escape-XmlText $Text
    return @"
<w:p>
  <w:pPr>
    <w:pStyle w:val="Caption"/>
    <w:jc w:val="center"/>
    <w:spacing w:line="288" w:lineRule="auto" w:before="0" w:after="120"/>
  </w:pPr>
  <w:r><w:fldChar w:fldCharType="begin"/></w:r>
  <w:r><w:instrText xml:space="preserve"> SEQ $Label \* ARABIC </w:instrText></w:r>
  <w:r><w:fldChar w:fldCharType="separate"/></w:r>
  <w:r><w:t>$Number</w:t></w:r>
  <w:r><w:fldChar w:fldCharType="end"/></w:r>
  <w:r><w:t xml:space="preserve">: $escapedText</w:t></w:r>
</w:p>
"@
}

function New-TableXml {
    param([object[]]$Rows)
    $rowXml = New-Object System.Collections.Generic.List[string]
    for ($r = 0; $r -lt $Rows.Count; $r++) {
        $cells = New-Object System.Collections.Generic.List[string]
        $row = $Rows[$r]
        foreach ($cell in $row) {
            $text = Escape-XmlText (($cell -replace '<br\s*/?>', ' ').Trim())
            $run = if ($r -eq 0) { New-RunXml -Text $text -Bold } else { New-RunXml -Text $text }
            $cells.Add(@"
<w:tc>
  <w:tcPr>
    <w:tcW w:w="2400" w:type="dxa"/>
    <w:tcBorders>
      <w:top w:val="single" w:sz="8" w:color="000000"/>
      <w:left w:val="single" w:sz="8" w:color="000000"/>
      <w:bottom w:val="single" w:sz="8" w:color="000000"/>
      <w:right w:val="single" w:sz="8" w:color="000000"/>
    </w:tcBorders>
  </w:tcPr>
  <w:p>
    <w:pPr>
      <w:jc w:val="center"/>
      <w:spacing w:line="288" w:lineRule="auto" w:before="0" w:after="0"/>
    </w:pPr>
    $run
  </w:p>
</w:tc>
"@)
        }
        $rowXml.Add("<w:tr>$($cells -join '')</w:tr>")
    }
    return @"
<w:tbl>
  <w:tblPr>
    <w:tblW w:w="0" w:type="auto"/>
    <w:tblBorders>
      <w:top w:val="single" w:sz="8" w:color="000000"/>
      <w:left w:val="single" w:sz="8" w:color="000000"/>
      <w:bottom w:val="single" w:sz="8" w:color="000000"/>
      <w:right w:val="single" w:sz="8" w:color="000000"/>
      <w:insideH w:val="single" w:sz="8" w:color="000000"/>
      <w:insideV w:val="single" w:sz="8" w:color="000000"/>
    </w:tblBorders>
  </w:tblPr>
  <w:tblGrid/>
  $($rowXml -join '')
</w:tbl>
"@
}

function New-ImageParagraphXml {
    param(
        [string]$RelId,
        [long]$Cx,
        [long]$Cy,
        [string]$Name,
        [int]$DocPrId
    )
    $safeName = Escape-XmlText $Name
    return @"
<w:p>
  <w:pPr>
    <w:jc w:val="center"/>
    <w:spacing w:line="288" w:lineRule="auto" w:before="0" w:after="120"/>
  </w:pPr>
  <w:r>
    <w:drawing>
      <wp:inline distT="0" distB="0" distL="0" distR="0" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing">
        <wp:extent cx="$Cx" cy="$Cy"/>
        <wp:docPr id="$DocPrId" name="$safeName"/>
        <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
          <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
            <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
              <pic:nvPicPr>
                <pic:cNvPr id="0" name="$safeName"/>
                <pic:cNvPicPr/>
              </pic:nvPicPr>
              <pic:blipFill>
                <a:blip r:embed="$RelId"/>
                <a:stretch><a:fillRect/></a:stretch>
              </pic:blipFill>
              <pic:spPr>
                <a:xfrm><a:off x="0" y="0"/><a:ext cx="$Cx" cy="$Cy"/></a:xfrm>
                <a:prstGeom prst="rect"><a:avLst/></a:prstGeom>
              </pic:spPr>
            </pic:pic>
          </a:graphicData>
        </a:graphic>
      </wp:inline>
    </w:drawing>
  </w:r>
</w:p>
"@
}

function Get-ImageSizeEmu {
    param([string]$Path)
    Add-Type -AssemblyName System.Drawing
    $img = [System.Drawing.Image]::FromFile($Path)
    try {
        $widthInches = $img.Width / $img.HorizontalResolution
        $heightInches = $img.Height / $img.VerticalResolution
        $maxWidth = 6.0
        if ($widthInches -gt $maxWidth) {
            $ratio = $maxWidth / $widthInches
            $widthInches = $maxWidth
            $heightInches = $heightInches * $ratio
        }
        return @{
            Cx = [long]($widthInches * 914400)
            Cy = [long]($heightInches * 914400)
        }
    }
    finally {
        $img.Dispose()
    }
}

function Add-ZipEntryText {
    param($Zip, [string]$EntryName, [string]$Content)
    $entry = $Zip.CreateEntry($EntryName)
    $stream = $entry.Open()
    $writer = New-Object System.IO.StreamWriter($stream, [System.Text.UTF8Encoding]::new($false))
    try { $writer.Write($Content) } finally { $writer.Dispose() }
}

function Add-ZipEntryFile {
    param($Zip, [string]$EntryName, [string]$SourcePath)
    $entry = $Zip.CreateEntry($EntryName)
    $source = [System.IO.File]::OpenRead($SourcePath)
    $dest = $entry.Open()
    try { $source.CopyTo($dest) } finally { $source.Dispose(); $dest.Dispose() }
}

function LatexToken-ToOmml {
    param([string]$Token)
    $Token = $Token.Trim()
    if ($Token -eq '') { return '' }
    $Token = $Token -replace '\\pi', "\u{03C0}"
    $Token = $Token -replace '\\,', ''
    $Token = $Token -replace '\\ ', ''

    if ($Token -match '^(.+)_\{([^}]+)\}\^\{([^}]+)\}$') {
        $base = $Matches[1]; $sub = $Matches[2]; $sup = $Matches[3]
        return "<m:sSubSup><m:sSubSupPr><m:ctrlPr/></m:sSubSupPr><m:e><m:r><m:t>$base</m:t></m:r></m:e><m:sub><m:r><m:t>$sub</m:t></m:r></m:sub><m:sup><m:r><m:t>$sup</m:t></m:r></m:sup></m:sSubSup>"
    }
    if ($Token -match '^(.+)\^\{([^}]+)\}$') {
        $base = $Matches[1]; $sup = $Matches[2]
        return "<m:sSup><m:sSupPr><m:ctrlPr/></m:sSupPr><m:e><m:r><m:t>$base</m:t></m:r></m:e><m:sup><m:r><m:t>$sup</m:t></m:r></m:sup></m:sSup>"
    }
    if ($Token -match '^(.+)_\{([^}]+)\}$') {
        $base = $Matches[1]; $sub = $Matches[2]
        return "<m:sSub><m:sSubPr><m:ctrlPr/></m:sSubPr><m:e><m:r><m:t>$base</m:t></m:r></m:e><m:sub><m:r><m:t>$sub</m:t></m:r></m:sub></m:sSub>"
    }
    if ($Token -match '^(.)\^(.)$') {
        $base = $Matches[1]; $sup = $Matches[2]
        return "<m:sSup><m:sSupPr><m:ctrlPr/></m:sSupPr><m:e><m:r><m:t>$base</m:t></m:r></m:e><m:sup><m:r><m:t>$sup</m:t></m:r></m:sup></m:sSup>"
    }
    if ($Token -match '^(.)_(.)$') {
        $base = $Matches[1]; $sub = $Matches[2]
        return "<m:sSub><m:sSubPr><m:ctrlPr/></m:sSubPr><m:e><m:r><m:t>$base</m:t></m:r></m:e><m:sub><m:r><m:t>$sub</m:t></m:r></m:sub></m:sSub>"
    }
    return "<m:r><m:t>$Token</m:t></m:r>"
}

function Latex-ToOmml {
    param([string]$Latex)
    $Latex = $Latex.Trim()
    $Latex = $Latex -replace '\\pi', "`u{03C0}"
    $Latex = $Latex -replace '\\,', ' '
    $Latex = $Latex -replace '\\\s', ' '
    $Latex = $Latex -replace '\\text\{([^}]+)\}', '$1'
    $parts = [regex]::Split($Latex, '(\s+|(?<=[=(),])|(?=[=(),]))')
    $omml = New-Object System.Collections.Generic.List[string]
    foreach ($p in $parts) {
        $t = $p.Trim()
        if ($t -eq '') { continue }
        if ($t -match '^[=(),\.+\-\u2026]$' -or $t -eq '...' -or $t -eq "`u{2014}") {
            $omml.Add("<m:r><m:t xml:space=`"preserve`"> $t </m:t></m:r>")
        } else {
            $omml.Add((LatexToken-ToOmml $t))
        }
    }
    return $omml -join ''
}

function New-BlockMathXml {
    param([string]$Latex)
    $inner = Latex-ToOmml $Latex
    return @"
<w:p>
  <w:pPr><w:jc w:val="center"/><w:spacing w:line="288" w:lineRule="auto" w:before="120" w:after="120"/></w:pPr>
  <m:oMathPara xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math">
    <m:oMath>$inner</m:oMath>
  </m:oMathPara>
</w:p>
"@
}

function Convert-InlineMathRuns {
    param([string]$Text, [switch]$Bold, [switch]$Italic)
    $segments = [regex]::Split($Text, '(\$[^$]+\$)')
    $runs = New-Object System.Collections.Generic.List[string]
    foreach ($seg in $segments) {
        if ($seg -match '^\$(.+)\$$') {
            $latex = $Matches[1]
            $inner = Latex-ToOmml $latex
            $runs.Add("<m:oMath xmlns:m=`"http://schemas.openxmlformats.org/officeDocument/2006/math`">$inner</m:oMath>")
        } elseif ($seg -ne '') {
            $runs.Add((New-RunXml -Text $seg -Bold:$Bold -Italic:$Italic))
        }
    }
    return $runs -join ''
}

function New-ParagraphWithMathXml {
    param(
        [string]$Text,
        [string]$Style = 'Normal',
        [string]$Justification = 'both',
        [switch]$Bold,
        [switch]$Italic
    )
    $pPr = @("<w:pStyle w:val=`"$Style`"/>")
    $pPr += "<w:jc w:val=`"$Justification`"/>"
    $pPr += '<w:spacing w:line="288" w:lineRule="auto" w:before="0" w:after="120"/>'
    $content = Convert-InlineMathRuns -Text $Text -Bold:$Bold -Italic:$Italic
    return "<w:p><w:pPr>$($pPr -join '')</w:pPr>$content</w:p>"
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$mdPath = Join-Path $root 'Tieu-luan-Cung-Cau-Canh-tranh-hoan-hao.md'
$docxPath = Join-Path $root 'Tieu-luan-Cung-Cau-Canh-tranh-hoan-hao.docx'

$lines = Read-LinesUtf8 -Path $mdPath
$body = New-Object System.Collections.Generic.List[string]
$imageRels = New-Object System.Collections.Generic.List[hashtable]
$figureCount = 0
$tableCount = 0
$docPrId = 1
$pendingTableCaption = $null

$section = New-FieldSectionXml -Title 'MUC LUC' -Instruction ' TOC \o "1-3" \h \z \u '
foreach ($item in $section) { $body.Add($item) }
$body.Add((New-PageBreakXml))
$section = New-FieldSectionXml -Title 'DANH MUC HINH ANH' -Instruction ' TOC \h \z \c "Figure" '
foreach ($item in $section) { $body.Add($item) }
$body.Add((New-PageBreakXml))
$section = New-FieldSectionXml -Title 'DANH MUC BANG BIEU' -Instruction ' TOC \h \z \c "Table" '
foreach ($item in $section) { $body.Add($item) }
$body.Add((New-PageBreakXml))

for ($i = 0; $i -lt $lines.Count; $i++) {
    $trimmed = $lines[$i].Trim()

    if ($trimmed -eq '' -or $trimmed -eq '---') { continue }
    if ($trimmed -eq '\newpage') {
        $body.Add((New-PageBreakXml))
        continue
    }

    if ($trimmed.StartsWith('![') -and $trimmed.Contains('](') -and $trimmed.EndsWith(')')) {
        $altStart = 2
        $altEnd = $trimmed.IndexOf('](')
        $altText = $trimmed.Substring($altStart, $altEnd - $altStart)
        $pathStart = $altEnd + 2
        $imgRelPath = $trimmed.Substring($pathStart, $trimmed.Length - $pathStart - 1)
        $imgPath = Join-Path $root $imgRelPath
        if (Test-Path $imgPath) {
            $figureCount++
            $relId = "rIdImg$figureCount"
            $imageRels.Add(@{
                Id = $relId
                EntryName = 'word/media/' + [System.IO.Path]::GetFileName($imgPath)
                SourcePath = $imgPath
            })
            $captionText = ($altText -replace '^[^:]+:\s*', '').Trim()
            $size = Get-ImageSizeEmu -Path $imgPath
            $body.Add((New-ImageParagraphXml -RelId $relId -Cx $size.Cx -Cy $size.Cy -Name ([System.IO.Path]::GetFileName($imgPath)) -DocPrId $docPrId))
            $docPrId++
            $body.Add((New-CaptionParagraphXml -Label 'Figure' -Number $figureCount -Text $captionText))
        }
        continue
    }

    if ($trimmed.StartsWith('**') -and $trimmed.EndsWith('**') -and $trimmed.Contains(':')) {
        $captionCandidate = $trimmed.Trim('*')
        if ($captionCandidate -match '^\S+\s+\d+\s*:') {
            $pendingTableCaption = ($captionCandidate -replace '^\S+\s+\d+\s*:\s*', '').Trim()
            continue
        }
    }

    if ($trimmed.StartsWith('#### ')) {
        $body.Add((New-ParagraphXml -Text $trimmed.Substring(5) -Style 'Heading3' -Justification 'left'))
        continue
    }
    if ($trimmed.StartsWith('### ')) {
        $body.Add((New-ParagraphXml -Text $trimmed.Substring(4) -Style 'Heading2' -Justification 'left'))
        continue
    }
    if ($trimmed.StartsWith('## ')) {
        $body.Add((New-ParagraphXml -Text $trimmed.Substring(3) -Style 'Heading1' -Justification 'left' -PageBreakBefore))
        continue
    }
    if ($trimmed.StartsWith('# ')) {
        $body.Add((New-ParagraphXml -Text $trimmed.Substring(2) -Style 'Title' -Justification 'center'))
        continue
    }

    if ($trimmed.StartsWith('|')) {
        $tableLines = New-Object System.Collections.Generic.List[string]
        while ($i -lt $lines.Count -and $lines[$i].Trim().StartsWith('|')) {
            $tableLines.Add($lines[$i].Trim())
            $i++
        }
        $i--
        $rows = New-Object System.Collections.Generic.List[object]
        for ($t = 0; $t -lt $tableLines.Count; $t++) {
            $raw = $tableLines[$t]
            if ($t -eq 1 -and $raw -match '^\|[:\-\s|]+\|$') { continue }
            $parts = $raw.Trim('|').Split('|') | ForEach-Object { $_.Trim() }
            $rows.Add($parts)
        }
        if ($pendingTableCaption) {
            $tableCount++
            $body.Add((New-CaptionParagraphXml -Label 'Table' -Number $tableCount -Text $pendingTableCaption))
            $pendingTableCaption = $null
        }
        $body.Add((New-TableXml -Rows $rows.ToArray()))
        continue
    }

    if ($trimmed -match '^\$\$(.+)\$\$$') {
        $body.Add((New-BlockMathXml -Latex $Matches[1]))
        continue
    }

    if ($trimmed.StartsWith('*') -and $trimmed.EndsWith('*') -and -not $trimmed.Contains('$')) {
        $body.Add((New-ParagraphXml -Text $trimmed.Trim('*') -Style 'Normal' -Justification 'left' -Italic))
        continue
    }

    $text = $trimmed -replace '\*\*', '' -replace '\*', ''
    if ($text.Contains('$')) {
        $body.Add((New-ParagraphWithMathXml -Text $text -Style 'Normal' -Justification 'both'))
    } else {
        $body.Add((New-ParagraphXml -Text $text -Style 'Normal' -Justification 'both'))
    }
}

$documentXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document
  xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
  xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
  xmlns:o="urn:schemas-microsoft-com:office:office"
  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
  xmlns:v="urn:schemas-microsoft-com:vml"
  xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing"
  xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
  xmlns:w10="urn:schemas-microsoft-com:office:word"
  xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
  xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml"
  xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup"
  xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk"
  xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
  xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape"
  mc:Ignorable="w14 wp14">
  <w:body>
    $($body -join "`n")
    <w:sectPr>
      <w:pgSz w:w="11906" w:h="16838"/>
      <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="708" w:footer="708" w:gutter="0"/>
      <w:cols w:space="708"/>
      <w:docGrid w:linePitch="360"/>
    </w:sectPr>
  </w:body>
</w:document>
"@

$stylesXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:docDefaults>
    <w:rPrDefault>
      <w:rPr>
        <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman" w:eastAsia="Times New Roman" w:cs="Times New Roman"/>
        <w:sz w:val="26"/><w:szCs w:val="26"/>
      </w:rPr>
    </w:rPrDefault>
    <w:pPrDefault>
      <w:pPr><w:spacing w:line="288" w:lineRule="auto" w:before="0" w:after="120"/></w:pPr>
    </w:pPrDefault>
  </w:docDefaults>
  <w:style w:type="paragraph" w:default="1" w:styleId="Normal">
    <w:name w:val="Normal"/><w:qFormat/>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Title">
    <w:name w:val="Title"/><w:basedOn w:val="Normal"/><w:qFormat/>
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="240" w:line="288" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:b/><w:sz w:val="30"/><w:szCs w:val="30"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading1">
    <w:name w:val="heading 1"/><w:basedOn w:val="Normal"/><w:next w:val="Normal"/><w:qFormat/>
    <w:pPr><w:outlineLvl w:val="0"/><w:spacing w:before="120" w:after="120" w:line="288" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:b/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading2">
    <w:name w:val="heading 2"/><w:basedOn w:val="Normal"/><w:next w:val="Normal"/><w:qFormat/>
    <w:pPr><w:outlineLvl w:val="1"/><w:spacing w:before="120" w:after="120" w:line="288" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:b/><w:sz w:val="27"/><w:szCs w:val="27"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading3">
    <w:name w:val="heading 3"/><w:basedOn w:val="Normal"/><w:next w:val="Normal"/><w:qFormat/>
    <w:pPr><w:outlineLvl w:val="2"/><w:spacing w:before="120" w:after="120" w:line="288" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:b/><w:sz w:val="26"/><w:szCs w:val="26"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Caption">
    <w:name w:val="caption"/><w:basedOn w:val="Normal"/><w:qFormat/>
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="120" w:line="288" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:i/></w:rPr>
  </w:style>
</w:styles>
"@

$rootRelsXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
  <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>
</Relationships>
"@

$docRelList = New-Object System.Collections.Generic.List[string]
$docRelList.Add('<Relationship Id="rIdStyles" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>')
$docRelList.Add('<Relationship Id="rIdSettings" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>')
foreach ($rel in $imageRels) {
    $docRelList.Add("<Relationship Id=`"$($rel.Id)`" Type=`"http://schemas.openxmlformats.org/officeDocument/2006/relationships/image`" Target=`"media/$([System.IO.Path]::GetFileName($rel.SourcePath))`"/>")
}
$docRelsXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  $($docRelList -join "`n  ")
</Relationships>
"@

$contentTypesXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Default Extension="png" ContentType="image/png"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
  <Override PartName="/word/settings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/>
  <Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
  <Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
</Types>
"@

$settingsXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:settings xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:updateFields w:val="true"/>
</w:settings>
"@

$stamp = [DateTime]::UtcNow.ToString('s') + 'Z'
$coreXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:title>Tieu luan</dc:title>
  <dc:creator>OpenAI Codex</dc:creator>
  <cp:lastModifiedBy>OpenAI Codex</cp:lastModifiedBy>
  <dcterms:created xsi:type="dcterms:W3CDTF">$stamp</dcterms:created>
  <dcterms:modified xsi:type="dcterms:W3CDTF">$stamp</dcterms:modified>
</cp:coreProperties>
"@

$appXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <Application>OpenAI Codex</Application>
</Properties>
"@

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
if (Test-Path $docxPath) { Remove-Item -LiteralPath $docxPath -Force }
$zip = [System.IO.Compression.ZipFile]::Open($docxPath, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    Add-ZipEntryText -Zip $zip -EntryName '[Content_Types].xml' -Content $contentTypesXml
    Add-ZipEntryText -Zip $zip -EntryName '_rels/.rels' -Content $rootRelsXml
    Add-ZipEntryText -Zip $zip -EntryName 'docProps/core.xml' -Content $coreXml
    Add-ZipEntryText -Zip $zip -EntryName 'docProps/app.xml' -Content $appXml
    Add-ZipEntryText -Zip $zip -EntryName 'word/document.xml' -Content $documentXml
    Add-ZipEntryText -Zip $zip -EntryName 'word/styles.xml' -Content $stylesXml
    Add-ZipEntryText -Zip $zip -EntryName 'word/settings.xml' -Content $settingsXml
    Add-ZipEntryText -Zip $zip -EntryName 'word/_rels/document.xml.rels' -Content $docRelsXml
    foreach ($rel in $imageRels) {
        Add-ZipEntryFile -Zip $zip -EntryName $rel.EntryName -SourcePath $rel.SourcePath
    }
}
finally {
    $zip.Dispose()
}

Write-Output "Created: $docxPath"
