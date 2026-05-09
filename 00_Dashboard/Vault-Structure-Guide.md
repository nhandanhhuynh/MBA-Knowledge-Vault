---
tags:
  - guide
  - mba
---

# Vault Structure Guide

> Hướng dẫn cấu trúc vault MBA - áp dụng tư duy ISO 19650 cho quản lý tài liệu học tập.

---

## Root Structure

```
028_MBA/
├── 00_Dashboard/           → Navigation, guides, MOC, daily notes
├── 01_Courses/             → Tất cả môn học
│   ├── 01_Active/          → Môn đang học
│   ├── 02_Completed/       → Môn đã hoàn thành
│   └── 03_Template-Course/ → Mẫu copy khi mở môn mới
├── 02_Thesis/              → Luận văn tốt nghiệp
├── 03_Resources/           → Tài nguyên dùng chung toàn chương trình
├── 04_Templates/           → Templates gốc (Course + Deliverable)
├── 90_Archive/             → Kho lưu trữ không dùng thường xuyên
└── 99_Attachments/         → Files đính kèm dùng chung
```

---

## Bên trong mỗi môn học

```
<Mã môn>/
├── 00_Course-Home.md       → Trang chủ môn học (AI đọc đầu tiên)
├── 01_Admin/               → Đề cương, lịch, rubric, thông báo
│   ├── Syllabus/
│   ├── Schedule/
│   ├── Rubric/
│   └── Announcements/
├── 02_Lectures/            → Ghi chú theo buổi học
├── 03_References/          → Tài liệu tham khảo
│   ├── Core/               → Giáo trình chính
│   ├── Supplement/         → Tài liệu bổ sung
│   └── Reading-Notes/      → Ghi chú khi đọc
├── 04_Deliverables/        → Bài tập, tiểu luận, thuyết trình
├── 05_Group-Work/          → Hợp tác nhóm
├── 06_Exam-Prep/           → Ôn tập thi
├── 07_AI-Workspace/        → Context & prompts cho AI
│   ├── Context/            → Summary cho AI hiểu môn
│   ├── Prompts/            → Prompt tái sử dụng
│   └── Outputs/            → Output AI cần review
└── 99_Attachments/         → Files riêng của môn
```

---

## Bên trong mỗi Deliverable

Mỗi bài tập/tiểu luận trong `04_Deliverables/` theo lifecycle:

```
<Tên deliverable>/
├── 00_Brief/       → Đề bài, yêu cầu, rubric
├── 01_Outline/     → Dàn ý, bố cục
├── 02_Draft/       → Bản nháp nghiêm túc
├── 03_WIP/         → Ghi chú đang làm, AI outputs thô
├── 04_Review/      → Bản chờ review
├── 05_Submit/      → Bản cuối cùng nộp
├── 06_Feedback/    → Nhận xét, điểm
└── 99_Attachments/ → Files đính kèm
```

---

## Nguyên tắc thiết kế

| Nguyên tắc | Mô tả |
|-------------|--------|
| **Chuẩn hóa folder, không ép file name** | Folder structure cố định, tên file linh hoạt |
| **File name tự do** | Được dùng tiếng Việt, không cần prefix bắt buộc |
| **Folder tiếng Anh** | Ổn định, AI-readable, không đổi |
| **Số thứ tự** | Đảm bảo sắp xếp đúng trong file explorer |
| **Mỗi môn có Course-Home** | Entry point cho cả người và AI |
| **Trạng thái nằm trong folder** | Không dùng tag status lộn xộn ở root |

---

## ISO 19650 Adaptation

| Concept ISO 19650 | Áp dụng trong vault |
|-------------------|---------------------|
| Common Data Environment | Vault + GitHub sync |
| Work In Progress (WIP) | `03_WIP/` trong deliverable |
| Shared | `04_Review/` - sẵn sàng chia sẻ |
| Published | `05_Submit/` - bản cuối |
| Archived | `90_Archive/` hoặc `02_Completed/` |
| Information Container | Mỗi note = 1 container |
| Suitability/Status | Folder lifecycle + stage tags |

---

## Khi nào di chuyển?

| Hành động | Điều kiện |
|-----------|-----------|
| Course → `02_Completed` | Khi môn kết thúc, có điểm |
| Deliverable → `06_Feedback` | Khi nhận phản hồi/điểm |
| Content → `90_Archive` | Không còn dùng, chỉ lưu trữ |
| AI output → `04_Review` | Sau khi AI-check xong, sẵn sàng review |

---
**Navigation**: [[00_Dashboard/Home|Home]]
