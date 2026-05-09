---
tags:
  - guide
  - mba
---

# New Course Checklist

> Checklist khi bắt đầu một môn học mới.

---

## Bước thực hiện

### 1. Tạo folder môn học

- [ ] Copy folder `01_Courses/03_Template-Course` (hoặc `04_Templates/Course-Template`)
- [ ] Đổi tên folder thành: `[Mã]-[Tên-môn-kebab-case]`
  - Ví dụ: `MS15-Digital-Transformation`
- [ ] Đặt vào `01_Courses/01_Active/`

### 2. Điền Course Home

- [ ] Mở `00_Course-Home.md`
- [ ] Điền: `course_name`, `course_code`, `semester`, `area`, `lecturer`, `credits`
- [ ] Cập nhật tags: thêm `#mba/semester/X`, `#area/...`
- [ ] Điền mô tả môn học
- [ ] Điền lịch học nếu có

### 3. Thêm tài liệu hành chính

- [ ] Đề cương → `01_Admin/Syllabus/`
- [ ] Lịch học → `01_Admin/Schedule/`
- [ ] Rubric → `01_Admin/Rubric/`

### 4. Thêm tài liệu tham khảo

- [ ] Giáo trình chính → `03_References/Core/`
- [ ] Tài liệu bổ sung → `03_References/Supplement/`

### 5. Setup AI Workspace

- [ ] Tạo/cập nhật `07_AI-Workspace/Context/course-context.md`
- [ ] Tóm tắt course objectives
- [ ] Tóm tắt rubric chính
- [ ] Note phong cách viết yêu cầu

### 6. Cập nhật Dashboard

- [ ] Cập nhật Dataview tự động hiển thị (không cần sửa thủ công nếu dùng query)

---

## Khi có deliverable mới

- [ ] Copy `04_Templates/Deliverable-Template`
- [ ] Đổi tên folder thành tên bài tập
- [ ] Đặt vào `04_Deliverables/` của môn
- [ ] Paste đề bài vào `00_Brief/`
- [ ] Bắt đầu dàn ý trong `01_Outline/`

---

## Khi môn kết thúc

- [ ] Cập nhật `course_status: completed` trong Course-Home
- [ ] Đổi tag `#mba/active` → `#mba/completed`
- [ ] Di chuyển folder từ `01_Active/` sang `02_Completed/`
- [ ] Ghi điểm cuối cùng vào Course-Home
- [ ] Review lại có gì cần archive

---
**Navigation**: [[00_Dashboard/Home|Home]]
