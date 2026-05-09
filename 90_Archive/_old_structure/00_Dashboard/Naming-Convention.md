---
tags:
  - convention
  - iso-19650
  - rule
aliases:
  - Naming Rules
  - File Naming
---

# 📋 Naming Convention Guide

> Based on **ISO 19650** information management principles adapted for academic use.

---

## 🏗️ ISO 19650 Principles Applied

| ISO 19650 Concept | MBA Application |
|-------------------|-----------------|
| Information Container | Each note/file = 1 container |
| Naming Convention | Standardized prefixes & codes |
| Status/Suitability | Status tags (draft → review → done) |
| Classification | Folder + Tag system |
| Version Control | Git + Obsidian File Recovery |
| CDE (Common Data Environment) | This Obsidian Vault + GitHub |

---

## 📁 Folder Naming Rules

```
[Number]_[Category-Name]
```

| Prefix | Category | Example |
|--------|----------|---------|
| `00_` | Dashboard & Navigation | `00_Dashboard` |
| `01_` | Core Subjects | `01_Core-Subjects` |
| `02_` | Major Subjects | `02_Major-Subjects` |
| `03_` | Electives | `03_Electives` |
| `04_` | Thesis | `04_Thesis` |
| `05_` | Resources | `05_Resources` |
| `06_` | Projects | `06_Projects` |
| `07_` | Templates | `07_Templates` |
| `08_` | Archive | `08_Archive` |
| `09_` | Attachments | `09_Attachments` |

---

## 📝 File Naming Rules

### Subject Folders
```
[Category][Number]-[Subject-Name-Kebab-Case]
```
- `CS01-Kinh-te-hoc-quan-ly` (Core Subject 01)
- `MS05-Quan-tri-van-hanh` (Major Subject 05)

### Note Files
```
[Type]-[SubjectCode]-[Description]
```

| Type Prefix | Meaning | Example |
|-------------|---------|---------|
| `LN` | Lecture Note | `LN-MS01-W03-Five-Forces.md` |
| `ASG` | Assignment | `ASG-CS02-Research-Proposal.md` |
| `CS` | Case Study | `CS-MS03-Vinamilk-Analysis.md` |
| `SUM` | Summary | `SUM-MS02-Marketing-Midterm.md` |
| `REF` | Reference | `REF-MS04-HR-Models.md` |
| `PRJ` | Project | `PRJ-MS07-Agile-Implementation.md` |

### Template Files
```
TPL-[Description]
```
- `TPL-Subject-New.md`
- `TPL-Lecture-Note.md`
- `TPL-Assignment.md`

---

## 🏷️ Tag Naming Rules

### Hierarchy
```
#[category]/[subcategory]
```

### Standard Tags

| Category | Tags |
|----------|------|
| **Type** | `#lecture-note`, `#assignment`, `#case-study`, `#book-note`, `#framework` |
| **Status** | `#status/active`, `#status/draft`, `#status/review`, `#status/done`, `#status/archived` |
| **Priority** | `#priority/high`, `#priority/medium`, `#priority/low` |
| **Semester** | `#sem/1`, `#sem/2`, `#sem/3`, `#sem/4` |
| **Subject Area** | `#area/finance`, `#area/marketing`, `#area/strategy`, `#area/hr`, `#area/operations` |

---

## 📊 Document Status Workflow (ISO 19650 Suitability)

```
S0: Work in Progress  →  #status/draft
S1: Shared            →  #status/review  
S2: Published         →  #status/done
S3: Archived          →  #status/archived
```

```mermaid
graph LR
    A[S0: Draft] --> B[S1: Review]
    B --> C[S2: Done]
    C --> D[S3: Archived]
    B --> A
```

---

## ✅ Naming Checklist

- [ ] Use **kebab-case** (hyphens, no spaces)
- [ ] Use **ASCII characters** for file names (no diacritics)
- [ ] Include **type prefix** for all note files
- [ ] Include **subject code** when relevant
- [ ] Keep names **concise but descriptive** (max 50 chars)
- [ ] Use **_Index.md** for folder overview files
- [ ] Date format: **YYYY-MM-DD**

---

## 💡 Examples

```
Good:
  LN-MS01-W01-Strategic-Planning.md
  ASG-CS02-Literature-Review-Draft.md
  CS-MS03-Tesla-Financial-Analysis.md

Bad:
  lecture note week 1.md          (spaces, no prefix)
  Bài tập nhóm.md                (Vietnamese in filename)
  note.md                         (too vague)
  MS01_Strategic_Management_Lecture_Week_1_Notes_Final_v2.md  (too long)
```

---

**Navigation**: [[00_Dashboard/Home|🏠 Home]]
