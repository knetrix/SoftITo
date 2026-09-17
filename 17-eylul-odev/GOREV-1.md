# Öğrenci, Bölüm ve Ders - 3NF

-   `departments`: Bölüm Bilgilerini Tutar.
-   `students`: Öğrenci Bilgilerini Tutar.
-   `courses`: Ders Bilgilerini Tutar.
-   `enrollments`: Öğrenci ve Ders Arasındaki Çoka Çok İlişkiyi Tutar.


Bir Öğrenci Bir Bölüme Bağlıdır. Bir Bölümde Birden Fazla Öğrenci Bulunabilir.

Bir Ders Bir Bölüme Bağlıdır. Bir Bölümde Birden Fazla Ders Bulunabilir.

Bir Öğrenci Birden Fazla Ders Alabilir. Bir Ders Birden Fazla Öğrenci Tarafından Alınabilir. Bu İlişki `enrollments` Köprü Tablosuyla Kurulur.

```sql
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    department_code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_number TEXT NOT NULL UNIQUE,
    full_name TEXT NOT NULL,
    department_id INTEGER NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_code TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    credit INTEGER NOT NULL CHECK (credit > 0),
    department_id INTEGER NOT NULL,

    FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS enrollments (
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    final_grade INTEGER CHECK (final_grade BETWEEN 0 AND 100),

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
```

## Örnek Veriler

```sql
INSERT INTO departments (department_code, name)
VALUES ('BM', 'Bilgisayar Mühendisliği');

INSERT INTO departments (department_code, name)
VALUES ('YZ', 'Yazılım Mühendisliği');
```

```sql
INSERT INTO students (
    student_number,
    full_name,
    department_id
)
VALUES (
    '2026001',
    'Ali Yılmaz',
    1
);
```

```sql
INSERT INTO courses (
    course_code,
    title,
    credit,
    department_id
)
VALUES (
    'FLU101',
    'Flutter Mobil Uygulama Geliştirme',
    4,
    2
);
```

```sql
INSERT INTO enrollments (
    student_id,
    course_id,
    final_grade
)
VALUES (
    1,
    1,
    85
);
```

### `departments`

| id | department_code | name |
|---:|---|---|
| 1 | BM | Bilgisayar Mühendisliği |
| 2 | YZ | Yazılım Mühendisliği |

### `students`

| id | student_number | full_name | department_id |
|---:|---|---|---:|
| 1 | 2026001 | Ali Yılmaz | 1 |

### `courses`

| id | course_code | title | credit | department_id |
|---:|---|---|---:|---:|
| 1 | FLU101 | Flutter Mobil Uygulama Geliştirme | 4 | 2 |

### `enrollments`

| student_id | course_id | enrollment_date | final_grade |
|---:|---:|---|---:|
| 1 | 1 | Güncel Tarih ve Saat | 85 |