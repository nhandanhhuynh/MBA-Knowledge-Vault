---
tags:
  - moc
  - dashboard
---

# 🏷️ Tag Index

> Complete reference of all tags used in this vault.

---

## By Type

```dataview
TABLE WITHOUT ID file.link as "Note", file.tags as "Tags"
FROM #lecture-note
SORT file.name ASC
LIMIT 20
```

## By Status

### Active
```dataview
LIST
FROM #status/active
SORT file.name ASC
```

### Draft
```dataview
LIST
FROM #status/draft
SORT file.name ASC
```

### Done
```dataview
LIST
FROM #status/done
SORT file.name ASC
```

---

## Tag Cloud Reference

### Content Types
- `#mba` - All MBA content
- `#subject` - Subject overview
- `#lecture-note` - Lecture notes
- `#assignment` - Assignments
- `#case-study` - Case studies
- `#book-note` - Book notes
- `#framework` - Business frameworks & models
- `#project` - Group/individual projects
- `#daily-note` - Daily notes
- `#weekly-review` - Weekly reviews

### Subject Areas
- `#area/strategy` - Strategic Management
- `#area/marketing` - Marketing
- `#area/finance` - Finance & Accounting
- `#area/hr` - Human Resources
- `#area/operations` - Operations & Supply Chain
- `#area/leadership` - Leadership & Organization
- `#area/economics` - Economics
- `#area/law` - Business Law
- `#area/technology` - MIS & E-Commerce
- `#area/research` - Research Methods

### Status
- `#status/active` - Currently in progress
- `#status/draft` - Work in progress (S0)
- `#status/review` - Ready for review (S1)
- `#status/done` - Completed (S2)
- `#status/archived` - Archived (S3)

### Priority
- `#priority/high` - Urgent / Important
- `#priority/medium` - Normal priority
- `#priority/low` - Can wait

### Semester
- `#sem/1` through `#sem/4`

---

**Navigation**: [[00_Dashboard/Home|🏠 Home]]
