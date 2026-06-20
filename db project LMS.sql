 
use LibraryManagementSystem_Project;


create table Authors (
    author_id int primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    nationality varchar(50)
);

create table Categories (
    category_id int primary key,
    category_name varchar(50) not null unique
);

create table Books (
    book_id int primary key,
    isbn varchar(20) not null unique,
    title varchar(150) not null,
    author_id int not null foreign key references Authors(author_id),
    category_id  int foreign key references Categories(category_id),
    total_copies int default 1 check (total_copies >= 1),
    shelf_location varchar(20)
);

create table Members (
    member_id int primary key,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    member_type varchar(20) default 'Student' check (member_type in ('Student','Faculty','Staff')),
    joined_date date default getdate(),
    borrow_limit int default 3
);

create table BorrowRecords (
    borrow_id int primary key,
    book_id int not null foreign key references Books(book_id),
    member_id int not null foreign key references Members(member_id),
    borrow_date date default getdate(),
    due_date date not null,
    return_date date,
    fine_amount float default 0
);

alter table Members
    add phone varchar(15)

alter table Books
    alter column shelf_location varchar(30)

insert into Authors values
(1, 'Roald','Dahl','British'),
(2, 'Jane','Austen','British'),
(3, 'Elif','Shafak','Turkish'),
(4, 'Mark','Twain','American'),
(5, 'Khaled','Hosseini','Afghan');

insert into Categories values
(1, 'Fiction'),
(2, 'Classic'),
(3, 'Science'),
(4, 'History'),
(5, 'Self-Help');

insert into Books values 
(1, '978-0451524935', 'There Are Rivers in the Sky', 3, 1, 4, 'A-01'),
(2, '978-0141439518', 'Pride and Prejudice', 2, 2, 3, 'B-05'),
(3, '978-1400079988', 'War and Peace', 3, 2, 2, 'B-06'),
(4, '978-0486280615', 'The Adventures of Tom Sawyer',4, 1, 5, 'A-09'),
(5, '978-1594631931', 'The Kite Runner', 5, 1, 3, 'A-12'),
(6, '978-0062316097', 'Charlie and The Chocolate Factory', 1, 1, 6, 'C-03'),
(7, '978-0140449136', 'Anna Karenina', 3, 2, 2, 'B-07');

insert into Members values 
(1, 'Hajira Tayyib', 'hajira@uni.edu', 'Student','2024-01-10', 3, null),
(2, 'Aleeha Wasim', 'aleeha@uni.edu', 'Student', '2024-01-15', 3, null),
(3, 'Faria Imran', 'faria@uni.edu', 'Student', '2024-02-01', 3, null),
(4, 'Aila Zameer','aila@uni.edu', 'Student', '2024-02-10', 3, null),
(5, 'Dr. Ahmed', 'ahmed@uni.edu', 'Faculty', '2023-09-01', 7, null),
(6, 'Sara Khan','sara@uni.edu', 'Staff', '2023-06-15', 5, null);

insert into BorrowRecords values 
(1, 1, 1, '2025-04-01', '2025-04-15', '2025-04-14', 0),
(2, 2, 2, '2025-04-05', '2025-04-19', null, 0),
(3, 3, 3, '2025-03-20', '2025-04-03', '2025-04-10', 35),
(4, 5, 4, '2025-04-10', '2025-04-24', null, 0),
(5, 1, 5, '2025-03-15', '2025-03-29', '2025-04-05', 70),
(6, 4, 1, '2025-04-12', '2025-04-26', null, 0),
(7, 6, 2, '2025-03-01', '2025-03-15', '2025-03-20', 25),
(8, 7, 5, '2025-04-18', '2025-05-02', null, 0);


select * from Categories

select * from Members where member_type = 'Student'

select * from Books where title like '%the%'

select top 3 * from Members order by joined_date desc

select getdate() as today

select isbn, substring(isbn, 1, 4) as isbn_prefix from Books

update BorrowRecords
set return_date = '2025-04-20', fine_amount = 5
where borrow_id = 2


-- books in category 1 or 2
select * from Books where category_id in (1, 2)

-- borrow records with fine between 10 and 50
select * from BorrowRecords where fine_amount between 10 and 50

-- distinct member types
select distinct member_type from Members

-- count how many books each author has
select author_id, count(*) as total_books
from Books
group by author_id

-- total fines collected from borrow records
select sum(fine_amount) as total_fines from BorrowRecords

-- average, min, max fine
select avg(fine_amount) as avg_fine,
       min(fine_amount) as min_fine,
       max(fine_amount) as max_fine
from BorrowRecords

-- members who have borrowed more than 1 book
select member_id, count(*) as borrow_count
from BorrowRecords
group by member_id
having count(*) > 1

-- books with more than 3 copies, ordered descending
select title, total_copies
from Books
where total_copies > 3
order by total_copies desc

-- Inner join
select b.title, a.first_name + ' ' + a.last_name as author_name
from Books b
inner join Authors a on b.author_id = a.author_id

-- Left join
select b.title, c.category_name
from Books b
left join Categories c on b.category_id = c.category_id

-- Right join
select b.title, c.category_name
from Books b
right join Categories c on b.category_id = c.category_id

-- Full outer join
select b.title, c.category_name
from Books b
full outer join Categories c on b.category_id = c.category_id

-- Inner join across 3 tables
select m.full_name, b.title, br.borrow_date, br.due_date, br.fine_amount
from BorrowRecords br
inner join Members m on br.member_id = m.member_id
inner join Books b on br.book_id   = b.book_id

-- Self join
select m2.full_name as same_year_member
from Members m1
inner join Members m2
    on year(m1.joined_date) = year(m2.joined_date)
    and m1.member_id <> m2.member_id
where m1.member_id = 1

-- Cross join
select top 10 m.full_name, c.category_name
from Members m
cross join Categories c

-- uncorrelated: books written by authors of British nationality
select title from Books
where author_id in (
    select author_id from Authors where nationality = 'British'
)

-- uncorrelated: members who have never borrowed a book
select full_name from Members
where member_id not in (
    select member_id from BorrowRecords
)

-- correlated: find members whose total fines are above average
select full_name
from Members m
where (
    select sum(fine_amount)
    from BorrowRecords br
    where br.member_id = m.member_id
) > (select avg(fine_amount) from BorrowRecords)

-- correlated: show each member's name and their total borrow count
select full_name,
    (select count(*) from BorrowRecords br where br.member_id = m.member_id) as total_borrows
from Members m

-- SP 1: borrow a book (checks stock, updates quantity, and inserts record)
create procedure sp_BorrowBook
    @borrow_id int,
    @book_id int,
    @member_id int,
    @due_date date
as
begin
    declare @current_stock int

    select @current_stock = total_copies from Books where book_id = @book_id

    if @current_stock <= 1
    begin
        print 'Error: Cannot borrow.'
        return; 
    end

    update Books 
    set total_copies = total_copies - 1 
    where book_id = @book_id

    insert into BorrowRecords (borrow_id, book_id, member_id, borrow_date, due_date)
    values (@borrow_id, @book_id, @member_id, getdate(), @due_date)

    print 'Book borrowed successfully. Stock updated.'
end

exec sp_BorrowBook 9, 3, 6, '2025-05-20'


-- SP 2: return a book and calculate fine (5 per overdue day)
create procedure sp_ReturnBook
    @borrow_id int,
    @return_date date
as
begin
    declare @due_date date
    declare @days_late int
    declare @fine float

    select @due_date = due_date from BorrowRecords where borrow_id = @borrow_id

    set @days_late = datediff(day, @due_date, @return_date)

    if @days_late > 0
        set @fine = @days_late * 5
    else
        set @fine = 0

    update BorrowRecords
    set return_date = @return_date, fine_amount = @fine
    where borrow_id = @borrow_id

    print 'Book returned. Fine: ' + cast(@fine as varchar)
end

exec sp_ReturnBook 4, '2025-05-01'


-- SP 3: search books by title keyword
create procedure sp_SearchBook
    @keyword varchar(100)
as
begin
    select b.book_id, b.title, b.shelf_location,
           a.first_name + ' ' + a.last_name as author,
           c.category_name
    from Books b
    inner join Authors a on b.author_id = a.author_id
    inner join Categories c on b.category_id = c.category_id
    where b.title like '%' + @keyword + '%'
end

exec sp_SearchBook 'the'

-- View 1: currently borrowed books (not yet returned)
create view vw_ActiveBorrows as
select m.full_name as member_name,
       b.title as book_title,
       br.borrow_date,
       br.due_date
from BorrowRecords br
inner join Members m on br.member_id = m.member_id
inner join Books   b on br.book_id   = b.book_id
where br.return_date is null

select * from vw_ActiveBorrows

-- View 2: overdue books with fine info
create view vw_OverdueBooks as
select m.full_name,
       b.title,
       br.due_date,
       br.return_date,
       br.fine_amount
from BorrowRecords br
inner join Members m on br.member_id = m.member_id
inner join Books b on br.book_id   = b.book_id
where br.fine_amount > 0

select * from vw_OverdueBooks

-- View 3: member borrow summary report
create view vw_MemberSummary as
select m.full_name,
       m.member_type,
       count(br.borrow_id) as total_borrows,
       sum(br.fine_amount) as total_fines
from Members m
left join BorrowRecords br on m.member_id = br.member_id
group by m.full_name, m.member_type

select * from vw_MemberSummary

-- Trigger 1: prevent borrowing if member already has 3+ active borrows
create trigger trg_CheckBorrowLimit
on BorrowRecords
instead of insert
as
begin
    declare @member_id int
    declare @active_count int
    declare @borrow_limit int

    select @member_id = member_id from inserted

    select @active_count = count(*)
    from BorrowRecords
    where member_id = @member_id and return_date is null

    select @borrow_limit = borrow_limit
    from Members
    where member_id = @member_id

    if @active_count >= @borrow_limit
    begin
        print 'Borrow limit reached. Cannot borrow more books.'
        rollback transaction
    end
    else
    begin
        insert into BorrowRecords
        select * from inserted
        print 'Borrow record added.'
    end
end


-- Trigger 2: log when a fine is charged (audit table)
create trigger trg_LogFine
on BorrowRecords
after update
as
begin
    if update(fine_amount)
    begin
        create table FineAuditLog (
    log_id int identity(1,1) primary key,
    borrow_id int,
    member_id int,
    fine_amount float,
    logged_at datetime default getdate()
);
        insert into FineAuditLog (borrow_id, member_id, fine_amount)
        select i.borrow_id, i.member_id, i.fine_amount
        from inserted i
        where i.fine_amount > 0
    end
end

exec sp_ReturnBook 6, '2025-05-05'
select * from FineAuditLog


-- Trigger 3: prevent deleting a book that is currently borrowed
create trigger trg_PreventBookDelete
on Books
instead of delete
as
begin
    declare @book_id int
    select @book_id = book_id from deleted

    if exists (
        select 1 from BorrowRecords
        where book_id = @book_id and return_date is null
    )
    begin
        print 'Cannot delete a book that is currently borrowed.'
        rollback transaction
    end
    else
    begin
        delete from Books where book_id = @book_id
        print 'Book deleted.'
    end
end