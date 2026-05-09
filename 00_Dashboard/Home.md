---
tags:
  - dashboard
  - home
aliases:
  - Homepage
  - MBA Home
---

# 🎓 MBA Knowledge Vault

> *"The only true wisdom is in knowing you know nothing."* — Socrates

Welcome to your MBA Knowledge Management System, powered by **Obsidian** and structured following **ISO 19650** principles for document management.

---

## 🧭 Quick Navigation

| | |
|---|---|
| 📚 [[MOC-Subjects\|Map of Content - Subjects]] | 📋 [[MOC-Projects\|Projects]] |
| 📖 [[05_Resources/Books/_Index-Books\|Books & Resources]] | 📅 [[Weekly-Review\|Weekly Reviews]] |
| 🎯 [[MOC-Goals\|Goals & Progress]] | 🏷️ [[MOC-Tags\|Tag Index]] |

---

## 📊 Study Progress

### Current Semester
```dataview
TABLE subject_name as "Subject", credits as "Credits", status as "Status"
FROM "01_Core-Subjects" OR "02_Major-Subjects"
WHERE status = "active"
SORT subject_code ASC
```

### Upcoming Deadlines
```dataview
TABLE subject as "Subject", deadline as "Deadline", weight as "Weight"
FROM #assignment
WHERE status != "done"
SORT deadline ASC
LIMIT 10
```

---

## 📈 Quick Stats

```dataview
TABLE WITHOUT ID
  length(filter(file.tasks, (t) => t.completed)) as "Done",
  length(filter(file.tasks, (t) => !t.completed)) as "Pending"
FROM "01_Core-Subjects" OR "02_Major-Subjects"
```

---

## 🗂️ Vault Structure

```
028_MBA/
├── 00_Dashboard/        → Navigation, MOCs, Daily Notes
├── 01_Core-Subjects/    → Kiến thức cơ sở ngành
├── 02_Major-Subjects/   → Kiến thức chuyên ngành
├── 03_Electives/        → Môn tự chọn
├── 04_Thesis/           → Luận văn tốt nghiệp
├── 05_Resources/        → Tài liệu tham khảo
├── 06_Projects/         → Bài tập, dự án
├── 07_Templates/        → Mẫu ghi chú
├── 08_Archive/          → Lưu trữ (hoàn thành)
└── 09_Attachments/      → Hình ảnh, files đính kèm
```

---

## 🏷️ Tag System

| Tag | Purpose |
|-----|---------|
| `#mba` | All MBA-related content |
| `#subject` | Subject overview notes |
| `#lecture-note` | Lecture notes |
| `#assignment` | Assignments & homework |
| `#case-study` | Case study analyses |
| `#book-note` | Book notes & summaries |
| `#framework` | Business frameworks |
| `#status/active` | Currently studying |
| `#status/done` | Completed |
| `#status/draft` | Work in progress |
| `#review` | Needs review |
| `#important` | High priority items |

---

## 📌 ISO 19650 Naming Convention

> See full guide: [[Naming-Convention|📋 Naming Convention Guide]]

**Format**: `[Type]-[Code]-[Description]`

Examples:
- `LN-MS01-W03-Marketing-Mix` (Lecture Note, Marketing, Week 3)
- `ASG-CS02-Research-Proposal` (Assignment, Research Methods)
- `CS-MS03-Vinamilk-Financial` (Case Study, Finance)

---

## 🔗 Quick Links
- [[07_Templates/TPL-Subject-New|➕ New Subject]]
- [[07_Templates/TPL-Lecture-Note|📝 New Lecture Note]]
- [[07_Templates/TPL-Assignment|📋 New Assignment]]
- [[07_Templates/TPL-Book-Note|📖 New Book Note]]
- [[07_Templates/TPL-Weekly-Review|📊 New Weekly Review]]

---

*Last updated: {{date:YYYY-MM-DD}}*
