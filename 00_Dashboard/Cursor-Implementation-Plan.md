# Kế hoạch tổ chức lại vault MBA cho Cursor AI

## 1. Mục tiêu

Tổ chức lại vault để:

- Phân biệt rõ môn đang học và môn đã học xong.
- Trong từng môn, tách rõ tài liệu tham khảo, ghi chú học tập, bài tập, tiểu luận, bài nhóm, bài thuyết trình, tài liệu nộp.
- Dùng được ngay trong Obsidian mà không cần naming convention quá cứng cho tên file.
- Giữ folder names đủ rõ để AI như Cursor, Codex, Claude hiểu ngay ngữ cảnh đang làm việc.
- Có template để khi mở môn mới chỉ cần copy một folder mẫu.
- Có tag và tài liệu hướng dẫn cụ thể để quản lý lộ trình MBA.

## 2. Nguyên tắc thiết kế

- Chuẩn hóa ở mức `folder structure`, không ép chuẩn ở mức `file name`.
- Tên file có thể dùng tiếng Việt nếu thuận tiện học tập.
- Tên folder nên ổn định, ngắn, và dễ hiểu với cả người và AI.
- Dùng số thứ tự để folder luôn sắp xếp đúng.
- Áp dụng tư duy gần ISO 19650 ở mức `trạng thái công việc`: `outline`, `draft`, `wip`, `review`, `submit`, `feedback`, `archive`.
- Không để trạng thái nằm lẫn lộn ở root; trạng thái chủ yếu nằm trong từng deliverable.
- Mỗi môn có một `Course Home` để AI và người dùng biết đây là môn gì, đang ở giai đoạn nào, có những đầu việc nào.

## 3. Cấu trúc root đề xuất

```text
028_MBA/
├── 00_Dashboard/
├── 01_Courses/
│   ├── 01_Active/
│   ├── 02_Completed/
│   └── 03_Template-Course/
├── 02_Thesis/
├── 03_Resources/
├── 04_Templates/
│   ├── Course-Template/
│   └── Deliverable-Template/
├── 90_Archive/
└── 99_Attachments/
```

## 4. Ý nghĩa từng folder root

- `00_Dashboard`
  - Trang chủ vault, lộ trình MBA, hướng dẫn dùng vault, MOC, tag guide, dashboard học tập.
- `01_Courses`
  - Nơi chứa tất cả các môn học.
- `01_Courses/01_Active`
  - Môn đang học hiện tại.
- `01_Courses/02_Completed`
  - Môn đã học xong, giữ lại để tra cứu.
- `01_Courses/03_Template-Course`
  - Một bản mẫu môn học có thể copy để mở môn mới.
- `02_Thesis`
  - Luận văn tốt nghiệp cấp chương trình, tách riêng vì quy mô lớn và kéo dài nhiều kỳ.
- `03_Resources`
  - Tài nguyên dùng chung toàn chương trình, không thuộc riêng một môn.
- `04_Templates`
  - Template dùng để copy nhanh cho môn mới và deliverable mới.
- `90_Archive`
  - Kho lưu trữ cấp vault cho nội dung không còn dùng thường xuyên.
- `99_Attachments`
  - File đính kèm dùng chung toàn vault; ưu tiên chỉ dùng cho tài liệu thật sự shared.

## 5. Cấu trúc chuẩn cho một môn học

Mỗi môn trong `01_Active` hoặc `02_Completed` nên có cấu trúc:

```text
<Mã môn hoặc Tên môn>/
├── 00_Course-Home.md
├── 01_Admin/
│   ├── Syllabus/
│   ├── Schedule/
│   ├── Rubric/
│   └── Announcements/
├── 02_Lectures/
├── 03_References/
│   ├── Core/
│   ├── Supplement/
│   └── Reading-Notes/
├── 04_Deliverables/
├── 05_Group-Work/
├── 06_Exam-Prep/
├── 07_AI-Workspace/
│   ├── Context/
│   ├── Prompts/
│   └── Outputs/
└── 99_Attachments/
```

## 6. Ý nghĩa từng folder trong môn học

- `00_Course-Home.md`
  - File trung tâm của môn học.
  - Chứa mô tả môn, giảng viên, kỳ học, trạng thái, danh sách deliverables, deadlines, link nhanh.
- `01_Admin`
  - Đề cương, lịch học, rubric, thông báo hành chính.
- `02_Lectures`
  - Ghi chú theo buổi học, slide tóm tắt, concept notes.
- `03_References`
  - Tài liệu tham khảo riêng của môn.
- `04_Deliverables`
  - Tất cả bài tập, tiểu luận, thuyết trình, case study, báo cáo nộp trong môn.
- `05_Group-Work`
  - Nội dung hợp tác nhóm không gắn chặt vào một deliverable cụ thể.
- `06_Exam-Prep`
  - Ôn tập giữa kỳ, cuối kỳ, flashcards, summary, mock questions.
- `07_AI-Workspace`
  - Nơi chuẩn bị context cho AI, prompt dùng nhiều lần, output cần rà soát.
- `99_Attachments`
  - Ảnh, pdf, file excel, file slide, biểu đồ, tài liệu đính kèm riêng của môn.

## 7. Cấu trúc chuẩn cho một deliverable

Mỗi item trong `04_Deliverables` dùng một folder riêng:

```text
<Tên deliverable>/
├── 00_Brief/
├── 01_Outline/
├── 02_Draft/
├── 03_WIP/
├── 04_Review/
├── 05_Submit/
├── 06_Feedback/
└── 99_Attachments/
```

## 8. Ý nghĩa trạng thái công việc

- `00_Brief`
  - Đề bài, yêu cầu, rubric, constraint, checklist nộp bài.
- `01_Outline`
  - Dàn ý, cấu trúc ý tưởng, bố cục thuyết trình, khung bài.
- `02_Draft`
  - Bản nháp có cấu trúc, đã bắt đầu viết nghiêm túc.
- `03_WIP`
  - Ghi chú đang làm, ý tưởng rời, phân tích dang dở, AI outputs chưa tinh chỉnh.
- `04_Review`
  - Bản sắp gửi review cho bản thân, nhóm, giảng viên hoặc AI kiểm tra.
- `05_Submit`
  - Bản cuối cùng đã nộp hoặc sẵn sàng nộp.
- `06_Feedback`
  - Nhận xét, điểm số, phiên bản đã phản hồi sau nộp.
- `99_Attachments`
  - Hình, bảng dữ liệu, tài liệu gốc riêng của deliverable đó.

## 9. Quy tắc AI-friendly

- Folder names dùng tiếng Anh ổn định như `Draft`, `WIP`, `Review`, `Submit`.
- File names được phép dùng tiếng Việt.
- Mỗi môn phải có `00_Course-Home.md`.
- Mỗi deliverable phải có một note index hoặc overview ở `00_Brief` hoặc root của deliverable.
- `07_AI-Workspace/Context` dùng để lưu:
  - course summary
  - assignment brief summary
  - grading rubric summary
  - current working status
- `07_AI-Workspace/Prompts` lưu prompt chuẩn tái sử dụng.
- `07_AI-Workspace/Outputs` lưu output từ AI cần kiểm tra lại.
- Không để AI làm việc trực tiếp trong `05_Submit` nếu chưa review.

## 10. Hệ tag Obsidian đề xuất

Chỉ giữ một hệ tag gọn và nhất quán.

### 10.1 Tag cấp chương trình

- `#mba`
- `#mba/active`
- `#mba/completed`
- `#mba/thesis`
- `#mba/semester/1`
- `#mba/semester/2`
- `#mba/semester/3`
- `#mba/semester/4`

### 10.2 Tag loại nội dung

- `#type/course-home`
- `#type/lecture-note`
- `#type/reference`
- `#type/reading-note`
- `#type/assignment`
- `#type/group-work`
- `#type/case-study`
- `#type/presentation`
- `#type/exam-prep`
- `#type/thesis`
- `#type/ai-context`
- `#type/ai-output`

### 10.3 Tag trạng thái

- `#stage/inbox`
- `#stage/outline`
- `#stage/draft`
- `#stage/wip`
- `#stage/review`
- `#stage/submit`
- `#stage/feedback`
- `#stage/done`
- `#stage/archive`

### 10.4 Tag lĩnh vực

- `#area/economics`
- `#area/research`
- `#area/statistics`
- `#area/law`
- `#area/strategy`
- `#area/marketing`
- `#area/finance`
- `#area/hr`
- `#area/operations`
- `#area/accounting`
- `#area/project-management`
- `#area/mis`
- `#area/supply-chain`
- `#area/ethics`
- `#area/leadership`
- `#area/international-business`
- `#area/innovation`
- `#area/ecommerce`

### 10.5 Tag AI workflow

- `#ai/context-ready`
- `#ai/needs-review`
- `#ai/final-checked`

## 11. Metadata frontmatter tối thiểu

Không ép naming convention, nhưng nên có frontmatter tối thiểu để Dataview và AI đọc dễ hơn.

### 11.1 Cho `00_Course-Home.md`

```yaml
course_name:
course_code:
semester:
course_status: active
area:
lecturer:
credits:
tags:
  - mba
  - type/course-home
```

### 11.2 Cho note của deliverable

```yaml
course_name:
course_code:
deliverable_type:
stage:
due_date:
owner:
tags:
  - mba
```

## 12. Tài liệu hướng dẫn cần tạo

Cursor AI cần tạo hoặc cập nhật các tài liệu sau:

- `00_Dashboard/Home.md`
  - Dashboard chính sau khi đổi cấu trúc.
- `00_Dashboard/Vault-Structure-Guide.md`
  - Giải thích toàn bộ root folders và folder trong môn.
- `00_Dashboard/Tags-Guide.md`
  - Danh sách tag chuẩn, khi nào dùng tag nào.
- `00_Dashboard/New-Course-Checklist.md`
  - Checklist khi tạo môn mới.
- `00_Dashboard/AI-Workflow-Guide.md`
  - Cách dùng Codex, Cursor, Claude trong vault.

## 13. Template cần tạo

Cursor AI cần tạo:

- `04_Templates/Course-Template/`
- `04_Templates/Deliverable-Template/`

### 13.1 `Course-Template` cần có

```text
Course-Template/
├── 00_Course-Home.md
├── 01_Admin/
├── 02_Lectures/
├── 03_References/
│   ├── Core/
│   ├── Supplement/
│   └── Reading-Notes/
├── 04_Deliverables/
│   └── _Template-Deliverable/
├── 05_Group-Work/
├── 06_Exam-Prep/
├── 07_AI-Workspace/
│   ├── Context/
│   ├── Prompts/
│   └── Outputs/
└── 99_Attachments/
```

### 13.2 `Deliverable-Template` cần có

```text
Deliverable-Template/
├── 00_Brief/
├── 01_Outline/
├── 02_Draft/
├── 03_WIP/
├── 04_Review/
├── 05_Submit/
├── 06_Feedback/
└── 99_Attachments/
```

## 14. Luồng sử dụng thực tế

### 14.1 Khi bắt đầu môn mới

1. Copy `04_Templates/Course-Template`.
2. Đổi tên folder thành tên môn.
3. Đặt vào `01_Courses/01_Active`.
4. Điền `00_Course-Home.md`.
5. Thêm đề cương vào `01_Admin`.
6. Thêm tài liệu học vào `03_References`.

### 14.2 Khi có bài tập hoặc tiểu luận mới

1. Copy `04_Templates/Deliverable-Template`.
2. Đổi tên thành tên đầu việc.
3. Đặt vào `04_Deliverables`.
4. Đưa đề bài vào `00_Brief`.
5. Dàn ý vào `01_Outline`.
6. Bản nháp vào `02_Draft`.
7. Ghi chú làm việc và AI output vào `03_WIP`.
8. Bản chờ duyệt vào `04_Review`.
9. Bản nộp cuối cùng vào `05_Submit`.
10. Nhận xét sau nộp vào `06_Feedback`.

### 14.3 Khi môn học kết thúc

1. Rà lại `00_Course-Home.md`.
2. Chuyển tag từ `#mba/active` sang `#mba/completed`.
3. Di chuyển folder môn từ `01_Active` sang `02_Completed`.
4. Giữ nguyên cấu trúc bên trong để tra cứu về sau.

## 15. Những thay đổi Cursor AI cần thực hiện

### Phase 1. Tạo cấu trúc mới

- Tạo root folders mới theo mục 3.
- Không xóa dữ liệu cũ ngay.
- Không đổi tên file note tiếng Việt trừ khi có xung đột rõ ràng.

### Phase 2. Tạo template và docs

- Tạo `Course-Template`.
- Tạo `Deliverable-Template`.
- Tạo các docs hướng dẫn ở `00_Dashboard`.

### Phase 3. Migrate môn học hiện có

- Di chuyển toàn bộ môn hiện tại vào `01_Courses/01_Active`.
- Chưa đưa gì vào `02_Completed` vì hiện chưa có môn nào xong.
- Với mỗi môn, tạo bổ sung các folder chuẩn còn thiếu.
- Giữ `_Index.md` cũ nếu cần, nhưng nên hợp nhất vào `00_Course-Home.md`.

### Phase 4. Cập nhật dashboard và queries

- Sửa các wikilinks bị thay đổi path.
- Sửa Dataview queries theo path mới.
- Dashboard phải đọc từ `01_Courses/01_Active` và `01_Courses/02_Completed`.

### Phase 5. Chuẩn hóa tags

- Loại bỏ các status cũ đang lẫn lộn như:
  - `pending`
  - `todo`
  - `reading`
  - `not-started`
- Thay bằng hệ tag/stage mới ở mục 10.

## 16. Ràng buộc khi Cursor AI thực hiện

- Không áp naming convention bắt buộc cho tên file.
- Không đổi tên tiếng Việt của note nếu không thật sự cần.
- Không làm mất dữ liệu cũ.
- Không xóa template cũ nếu chưa xác nhận nội dung nào còn dùng.
- Nếu phải đổi link hoặc Dataview path thì cập nhật đồng bộ.
- Ưu tiên tính dễ dùng hàng ngày hơn “đúng chuẩn” hình thức.

## 17. Tiêu chí hoàn thành

Kế hoạch được xem là hoàn thành khi:

- Có root structure mới rõ ràng.
- Có folder riêng cho `Active` và `Completed`.
- Mỗi môn có `00_Course-Home.md`.
- Có template môn học và template deliverable dùng copy được ngay.
- Có guide về structure, tags, và AI workflow.
- Dashboard đọc đúng các môn active/completed.
- Không còn hệ status lộn xộn cũ trong notes chính.
- AI có thể nhìn folder là hiểu đang làm việc ở giai đoạn nào.

## 18. Prompt đề xuất để đưa cho Cursor AI

```text
Reorganize this Obsidian MBA vault into a clearer AI-friendly structure.

Goals:
- Separate active courses and completed courses.
- Keep Vietnamese file names if needed.
- Standardize folder structure, not file naming.
- Use lifecycle folders inspired by ISO 19650 inside each deliverable: Outline, Draft, WIP, Review, Submit, Feedback.
- Create reusable templates for a new course and a new deliverable.
- Create clear Obsidian guide documents for folder structure, tags, and AI workflow.
- Update dashboard pages, wiki-links, and Dataview queries after moving folders.

Required target structure:
- 00_Dashboard
- 01_Courses/01_Active
- 01_Courses/02_Completed
- 01_Courses/03_Template-Course
- 02_Thesis
- 03_Resources
- 04_Templates/Course-Template
- 04_Templates/Deliverable-Template
- 90_Archive
- 99_Attachments

For each active course, ensure this internal structure exists:
- 00_Course-Home.md
- 01_Admin
- 02_Lectures
- 03_References/Core
- 03_References/Supplement
- 03_References/Reading-Notes
- 04_Deliverables
- 05_Group-Work
- 06_Exam-Prep
- 07_AI-Workspace/Context
- 07_AI-Workspace/Prompts
- 07_AI-Workspace/Outputs
- 99_Attachments

For each deliverable template, create:
- 00_Brief
- 01_Outline
- 02_Draft
- 03_WIP
- 04_Review
- 05_Submit
- 06_Feedback
- 99_Attachments

Also create these docs:
- 00_Dashboard/Vault-Structure-Guide.md
- 00_Dashboard/Tags-Guide.md
- 00_Dashboard/New-Course-Checklist.md
- 00_Dashboard/AI-Workflow-Guide.md

Use a consistent tag system with:
- program tags
- content-type tags
- stage tags
- area tags
- ai workflow tags

Do not enforce a strict naming convention for note file names.
Do not delete existing content.
Do not leave broken wiki-links or Dataview queries.
```

## 19. Khuyến nghị cuối

Thiết kế này không cố “bắt chước ISO 19650 đầy đủ”, mà chỉ mượn phần hữu ích nhất cho học tập cá nhân:

- trạng thái công việc rõ ràng
- tách active/completed
- có template để scale
- AI nhìn folder là hiểu workflow

Đây là mức chuẩn hóa vừa đủ để dùng lâu dài mà không làm việc học bị nặng tay quản trị.
