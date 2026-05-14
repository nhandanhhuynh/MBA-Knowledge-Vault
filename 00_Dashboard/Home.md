---
tags:
  - mba
  - dashboard
aliases:
  - Homepage
  - MBA Home
---

# MBA Knowledge Vault

> *"An investment in knowledge pays the best interest."* — Benjamin Franklin

---

## Quick Navigation

| | |
|---|---|
| [[Vault-Structure-Guide\|Vault Structure]] | [[Tags-Guide\|Tags Guide]] |
| [[AI-Workflow-Guide\|AI Workflow]] | [[New-Course-Checklist\|New Course Checklist]] |
| [[LLM-Wiki-Integration-Guide\|LLM Wiki Integration]] | [[Kanban-Board\|Kanban Tasks]] |
| [[02_Thesis/00_Thesis-Home\|Thesis]] | |

---

## Active Courses

```dataview
TABLE WITHOUT ID
  file.link as "Course",
  course_code as "Code",
  area as "Area",
  semester as "Sem",
  credits as "Cr"
FROM "01_Courses/01_Active"
WHERE contains(tags, "type/course-home")
SORT course_code ASC
```

---

## Upcoming Deadlines

```dataview
TABLE WITHOUT ID
  file.link as "Deliverable",
  course_name as "Course",
  due_date as "Deadline",
  stage as "Stage"
FROM "01_Courses/01_Active"
WHERE due_date != null AND stage != "done" AND stage != "archive"
SORT due_date ASC
LIMIT 10
```

---

## Recently Modified

```dataview
TABLE WITHOUT ID
  file.link as "Note",
  file.folder as "Location",
  file.mtime as "Modified"
FROM "01_Courses" OR "02_Thesis"
WHERE file.name != "00_Course-Home"
SORT file.mtime DESC
LIMIT 10
```

---

## Completed Courses

```dataview
TABLE WITHOUT ID
  file.link as "Course",
  course_code as "Code",
  area as "Area"
FROM "01_Courses/02_Completed"
WHERE contains(tags, "type/course-home")
SORT course_code ASC
```

---

## Vault Structure

```
028_MBA/
├── 00_Dashboard/           → You are here
├── 01_Courses/
│   ├── 01_Active/          → 18 courses
│   ├── 02_Completed/       → Done courses
│   └── 03_Template-Course/ → Copy for new course
├── 02_Thesis/              → Graduation thesis
├── 03_Resources/           → Shared resources
├── 04_Templates/           → Master templates
├── 90_Archive/             → Cold storage
└── 99_Attachments/         → Shared files
```

---

## Quick Actions

- **New Course**: Copy `01_Courses/03_Template-Course` → rename → put in `01_Active`
- **New Deliverable**: Copy `04_Templates/Deliverable-Template` → rename → put in course `04_Deliverables/`
- **New Lecture Note**: Create note in course `02_Lectures/`
- **Daily Note**: Use Calendar plugin or `Ctrl+P` → "Daily Note"

---
*Vault synced with [GitHub](https://github.com/nhandanhhuynh/MBA-Knowledge-Vault)*
