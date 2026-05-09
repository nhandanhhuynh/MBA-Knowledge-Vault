---
tags:
  - guide
  - setup
---

# Setup Guide - MBA Knowledge Vault

---

## 1. GitHub Repository Setup

### Create the repo on GitHub:
1. Go to https://github.com/new
2. Repository name: `MBA-Knowledge-Vault`
3. Description: `MBA study vault - Obsidian + ISO 19650`
4. Set to **Private** (recommended for personal study notes)
5. Do NOT initialize with README (we already have one)
6. Click "Create repository"

### Push existing content:
Open terminal in this folder and run:
```bash
git push -u origin main
```

If prompted for authentication, use a **Personal Access Token** (Settings > Developer settings > Personal access tokens > Fine-grained tokens).

---

## 2. Obsidian Setup

### First time opening:
1. Open Obsidian
2. Click "Open folder as vault"
3. Select `D:\01_Doc\00_Education\028_MBA`
4. When prompted about community plugins, click "Trust author and enable plugins"
5. Go to Settings > Community plugins > Browse
6. Install the plugins listed below (manifest files are pre-configured)

### Plugins to install from Community:
1. **Dataview** - for dynamic tables and queries
2. **Templater** - for smart templates
3. **Calendar** - for daily/weekly note calendar
4. **Kanban** - for task boards
5. **Git** (by Vinzent) - for GitHub sync
6. **Excalidraw** - for diagrams

### After installing plugins:
- Enable each plugin in Settings > Community plugins
- Plugins will auto-load their configurations from `.obsidian/plugins/`

### Enable CSS Snippet:
1. Go to Settings > Appearance > CSS Snippets
2. Enable `custom-styling`

---

## 3. Obsidian Git Plugin Setup

After installing the Git plugin:
1. Settings > Git > Auto backup interval: `10` minutes
2. Auto pull on boot: `ON`
3. Push on auto commit: `ON`
4. The plugin will auto-commit and push your changes

---

## 4. Daily Workflow

### Start of day:
1. Open Calendar sidebar (right panel)
2. Click today's date → creates daily note from template
3. Review Kanban board for pending tasks

### During study:
1. Use `Ctrl+N` → select template for new notes
2. Follow naming convention: `LN-MS01-W01-Topic.md`
3. Add tags from the tag system

### End of day:
1. Fill in daily note summary
2. Update Kanban board
3. Git plugin auto-commits (or manual: `Ctrl+P` → "Git: Commit")

### Weekly:
1. Create weekly review from template
2. Review goals and progress

---

## 5. Adding a New Subject

1. Copy template from `07_Templates/TPL-Subject-New.md`
2. Create folder: `[Category][Number]-[Subject-Name]`
3. Create `_Index.md` inside the new folder
4. Update `00_Dashboard/MOC-Subjects.md`
5. Add the new subject link

Or use Templater: `Ctrl+P` → "Templater: Create new note from template"

---

## 6. Useful Hotkeys

| Action | Hotkey |
|--------|--------|
| Quick Switcher | `Ctrl+O` |
| Command Palette | `Ctrl+P` |
| Search in files | `Ctrl+Shift+F` |
| New note | `Ctrl+N` |
| Toggle sidebar | `Ctrl+B` |
| Graph view | `Ctrl+G` |
| Back | `Alt+←` |
| Forward | `Alt+→` |

---

**Navigation**: [[00_Dashboard/Home|🏠 Home]]
