-------------------------------STORE--------------------------------------------------
 --Bảng Account--
 
 if OBJECT_ID('CHECKLOGIN') is not null drop PROC CHECKLOGIN;
 go
--1. Kiểm tra đăng nhập khi login vào.
create PROC CHECKLOGIN 
 @UserName varchar(50),
 @Pass varchar(50)
as
begin  
	select * from dbo.Account where UserName=@UserName AND Pass=@Pass;
end
go

if OBJECT_ID('LOADAccount') is not null drop PROC LOADAccount;
go
--2. Load dữ liệu bảng Account vào datagridView.
create PROC LOADAccount 
as
begin 
	select ID,NamePerson, UserName,Pass,TypePerson 
	from Account
	order by NamePerson asc
end
go

if OBJECT_ID('INSERTAccount') is not null drop proc INSERTAccount;
go
--3. Thêm Account vào bảng Account.
create proc INSERTAccount
@NamePerson varchar(50),
@UserName varchar(50),
@Pass varchar(50),
@TypePerson int
as
begin
	declare @CheckUser varchar(50)
	select @CheckUser=UserName
	from Account
	where @UserName=UserName;

	if @UserName=@CheckUser or @UserName is null
		Throw 50001,'Not insert Account.',1;
	else
		Insert Account (NamePerson,UserName,Pass,TypePerson)
		values (@NamePerson,@UserName,@Pass,@TypePerson)
end
go

if OBJECT_ID('RePassAccount') is not null drop proc RePassAccount;
go
--4. Reset Password về thành 1. Khi nhấn sự kiện trên visual.
create proc RePassAccount
@Id int,
@Pass varchar(50)
as
begin
	update Account set Pass=@Pass where ID=@Id;
end
go

if OBJECT_ID('UPDATEAccount') is not null drop proc UPDATEAccount
go
--5. Thay Đổi PassWord của Account đã chọn trong bảng Account.
create proc UPDATEAccount
@id int,
@pass varchar(50)
as
begin
	UPDATE Account Set Pass=@pass where ID=@id;
end;
go

if OBJECT_ID('DELETEAccount') is not null drop proc DELETEAccount;
go
--6. Xóa Account đã chọn trong bảng Account.
create proc DELETEAccount
@Id int
as
begin
	Delete Account where ID=@Id;
end
go
--Bảng NGÀNH--
if OBJECT_ID('LOADNganh') is not null drop PROC LOADNganh;
go
--7. Load dữ liệu bảng NGÀNH vào datagridView.
create PROC LOADNganh
as
begin
	select MaNganh,TenNganh,ChiTieu,DiemChuan
	from NGANH
end
go

if OBJECT_ID('INSERTNganh') is not null drop proc INSERTNganh;
go
--8. Thêm Ngành mới vào bảng NGÀNH.
create proc INSERTNganh
@MaNganh varchar(50), @TenNganh varchar(50), @ChiTieu int, @DiemChuan float

as
begin 
	declare @CheckMaNganh varchar(50);
	
	select @CheckMaNganh=@MaNganh
	from NGANH
	where MaNganh=@MaNganh;

	Insert NGANH (MaNganh, TenNganh, ChiTieu, DiemChuan)
		values(@MaNganh, @TenNganh, @ChiTieu, @DiemChuan);
end
go

if OBJECT_ID('EDITNganh') is not null drop proc EDITNganh;
go
--9 Sửa giá trị Ngành đã chọn trong bảng NGÀNH.
create proc EDITNganh
@MaNganh varchar (50),
@TenNganh varchar(100),
@ChiTieu int,
@DiemChuan float
as
begin 
	declare @checkmanganh varchar(50)
	select @checkmanganh=MANGANH 
	from NGANH
	where @MaNganh=MaNganh;

	if @checkmanganh = @MaNganh 
		update NGANH set TenNganh=@TenNganh, ChiTieu=@ChiTieu where MANGANH=@MaNganh 
	else
		update NGANH set MaNganh=@checkmanganh, TenNganh=@TenNganh, ChiTieu=@ChiTieu, DiemChuan=@DiemChuan where MANGANH=@MaNganh 
end
go

if OBJECT_ID('DELETENganh') is not null drop proc DELETENganh;
go
--10. Xóa giá trị Ngành đã chọn trong bảng NGÀNH.
create proc DELETENganh
@id int
as
begin 
	Delete NGANH where MaNganh=@id;
end
go
--Bảng ĐỐI TƯỢNG--
if OBJECT_ID('LOADDoiTuong') is not null drop PROC LOADDoiTuong;
go
--11. Load dữ liệu bảng ĐỐI TƯỢNG vào datagridView.
create PROC LOADDoiTuong
as
begin 
	select  MaDoiTuong,LoaiDoiTuong,DiemCongDTuong
	from DOITUONG
	order by MaDoiTuong;
end
go

if OBJECT_ID('INSERTDoituong') is not null drop proc INSERTDoituong
go
--12. Thêm giá trị Đối Tượng vào bảng ĐỐI TƯỢNG.
create proc INSERTDoituong
@LoaiDoiTuong varchar(100), @DiemCongDTuong float
as
begin 
	declare @MaDoiTuong int;
	
	select @MaDoiTuong=@MaDoiTuong
	from DOITUONG
	where LoaiDoiTuong=@LoaiDoiTuong;

	Insert DOITUONG(MaDoituong, LoaiDoiTuong, DiemCongDTuong)
		values(@MaDoiTuong, @LoaiDoiTuong, @DiemCongDTuong);
end
go

if OBJECT_ID('EDITDoituong') is not null drop proc EDITDoituong;
go
--13. Sửa giá trị đối tượng đã chọn trong bảng ĐỐI TƯỢNG.
create proc EDITDoituong
@MaDoiTuong int ,
@LoaiDoiTuong varchar(100),
@DiemCongDTuong float
as
begin 
	declare @checkmadoituong int
	select @checkmadoituong=MADOITUONG 
	from DOITUONG
	where @MaDoiTuong=MaDoiTuong;

	if @checkmadoituong = @MaDoiTuong
		update DOITUONG set LoaiDoiTuong=@LoaiDoiTuong, DiemCongDTuong=@DiemCongDTuong where MADOITUONG=@MaDoiTuong
	else
		update DOITUONG set MaDoiTuong=@checkmadoituong,LoaiDoiTuong=@LoaiDoiTuong, DiemCongDTuong=@DiemCongDTuong where MADOITUONG=@MaDoiTuong 
end
go

if OBJECT_ID('DELETEDoituong') is not null drop proc DELETEDoituong;
go
--14. Xóa giá trị đã chọn trong bảng ĐỐI TƯỢNG.
create proc DELETEDoituong
@id int
as
begin 
	Delete DOITUONG where MaDoiTuong=@id;
end
go

--Bảng HỘ KHẨU--

if OBJECT_ID('LOADHoKhau') is not null drop PROC LOADHoKhau;
go
--15. Load dữ liệu bảng HỘ KHẨU vào datagridView.
create PROC LOADHoKhau
as
begin 
	select MaHoKhau, TenTinh,TenHuyen,KHUVUC.MaKhuVuc,TenKhuVuc,DiemCongKV
	from HOKHAU join KHUVUC on HOKHAU.MaKhuVuc=KHUVUC.MaKhuVuc
	order by TenTinh asc,cast(HOKHAU.MaHoKhau as int) desc,TenHuyen asc;
end
go

if OBJECT_ID('INSERTHoKhau') is not null drop proc INSERTHoKhau
go
--16. Thêm giá trị Hộ Khẩu vào Bảng HỘ KHẨU.
create proc INSERTHoKhau
@tenhuyen varchar(50), @tentinh varchar(50), @tenkhuvuc varchar(50)
as
begin 
	declare @MaKhuVuc varchar(50);
	
	select @MaKhuVuc=MaKhuVuc
	from KHUVUC
	where TenKhuVuc=@tenkhuvuc;

	Insert HOKHAU (TenHuyen,TenTinh,MaKhuVuc)
		values(@tenhuyen,@tentinh,@MaKhuVuc);
end
go


if OBJECT_ID('EDITHoKhau') is not null drop proc EDITHoKhau;
go
--17. Sửa giá trị Hộ Khẩu đã chọn trong Bảng HỘ KHẨU.
create proc EDITHoKhau
@mahokhau varchar(50),
@tentinh varchar(50),
@tenhuyen varchar(50),
@makhuvuc varchar(50),
@tenkhuvuc varchar(50)
as
begin 
	declare @checkmakhuvuc varchar(50)
	select @checkmakhuvuc=MaKhuVuc
	from KHUVUC
	where @tenkhuvuc=TenKhuVuc;

	if @checkmakhuvuc = @makhuvuc
		update HOKHAU set TenTinh=@tentinh, TenHuyen=@tenhuyen where MaHoKhau=@mahokhau
	else
		update HOKHAU set TenTinh=@tentinh, TenHuyen=@tenhuyen, MaKhuVuc=@checkmakhuvuc where MaHoKhau=@mahokhau
end;
go

if OBJECT_ID('DELETEHoKhau') is not null drop proc DELETEHoKhau;
go
--18. Xóa giá trị Hộ Khẩu đã chọn trong bảng HỘ KHẨU.
create proc DELETEHoKhau
@id int
as
begin 
	Delete HOKHAU where MaHoKhau=@id;
end
go

--Bảng HỒ SƠ THÍ SINH--
if OBJECT_ID('LOADTableHoSoThiSinh') is not null drop PROC LOADTableHoSoThiSinh
go
--19. Load dữ liệu bảng HỒ SƠ THÍ SINH vào datagridView.
 create PROC LOADTableHoSoThiSinh
 as
 begin 
select SBD, HoDem,Ten,NgaySinh,GioiTinh,HOSOTHISINH.MaHoKhau,TenHuyen,TenTinh,HOSOTHISINH.MaDoiTuong,LoaiDoiTuong, HOSOTHISINH.MaDanToc,TenDanToc,Toan,Ly,Hoa,Sinh,Van,Su,Dia,AnhVan
from ((HOSOTHISINH	join HOKHAU	  on HOSOTHISINH.MaHoKhau=HOKHAU.MaHoKhau) 
					join DOITUONG on HOSOTHISINH.MaDoiTuong=DOITUONG.MaDoiTuong)
					join DANTOC	  on HOSOTHISINH.MaDanToc=DANTOC.MaDanToc
order by cast(SBD as int);
end
go

if OBJECT_ID('INSERTHoSoThiSinh') is not null drop proc INSERTHoSoThiSinh;
go
--20. Thêm giá trị hồ sơ thí sinh vào bảng HỒ SƠ THÍ SINH
create proc INSERTHoSoThiSinh
@sbd varchar(10),@hodem varchar(50),@ten varchar(50),@ngaysinh smalldatetime,@gioitinh bit,@tenhuyen varchar(50),@tentinh varchar(50),@doituong varchar(50),
@dantoc varchar(50),@toan float,@ly float,@hoa float,@sinh float,@van float,@su float,@dia float,@anhvan float
as
begin 
	begin try
		begin tran
		declare @mahokhau int
			select @mahokhau=MaHoKhau
			from HOKHAU
			where TenHuyen=@tenhuyen and TenTinh=@tentinh
		declare @madoituong int
			select @madoituong = MaDoiTuong
			from DOITUONG
			where LoaiDoiTuong=@doituong
		declare  @madantoc int
			select @madantoc=MaDanToc
			from DANTOC
			where TenDanToc=@dantoc
		if(@mahokhau is not null and @madoituong is not null and @madantoc is not null)
		begin
			Insert HOSOTHISINH(SBD,HoDem,Ten,NgaySinh,GioiTinh,MaHoKhau,MaDoiTuong,MaDanToc,Toan,Ly,Hoa,Sinh,Van,Su,Dia,AnhVan)
			values (@sbd,@hodem,@ten, @ngaysinh,@gioitinh,@mahokhau,@madoituong,@madantoc,@toan,@ly,@hoa,@sinh,@van,@su,@dia,@anhvan)
		end;
		commit tran
	end try
	begin catch
		rollback tran;
		throw 5000,'Lỗi insert',1;
	end catch
end;
GO
-------------------------------------------------------------Index-----------------------------
create nonclustered index idx_ncc_HOKHAU_TenTinh_TenHuyen
on HOKHAU(TenTinh)
include(TenHuyen,MaHoKhau);
go

create nonclustered index idx_ncc_DOITUONG_LoaiDoiTuong
on DOITUONG(LoaiDoiTuong)
include (MaDoiTuong);
go

create nonclustered index idx_ncc_DANTOC_TenDanToc
on DANTOC(TenDanToc)
include (MaDanToc);
go
--------------------------------------------------------------
if OBJECT_ID('UPDATEHoSoThiSinh') is not null drop proc UPDATEHoSoThiSinh;
go
--21. Sửa giá trị hồ sơ thí sinh trong bảng HỒ SƠ THÍ SINH
create proc UPDATEHoSoThiSinh
@sbd varchar(10),@hodem varchar(50),@ten varchar(50),@ngaysinh smalldatetime,@gioitinh bit,@tenhuyen varchar(50),@tentinh varchar(50),@doituong varchar(50),
@dantoc varchar(50),@toan float,@ly float,@hoa float,@sinh float,@van float,@su float,@dia float,@anhvan float
as
begin 
	declare @mahokhau int
		select @mahokhau=MaHoKhau
		from HOKHAU
		where TenHuyen=@tenhuyen and TenTinh=@tentinh
	declare @madoituong int
		select @madoituong = MaDoiTuong
		from DOITUONG
		where LoaiDoiTuong=@doituong
	declare  @madantoc int
		select @madantoc=MaDanToc
		from DANTOC
		where TenDanToc=@dantoc
		if(@mahokhau is not null and @madoituong is not null and @madantoc is not null)
		begin
			Update HOSOTHISINH set HoDem=@hodem , Ten=@ten , NgaySinh=@ngaysinh , GioiTinh=@gioitinh,
			MaHoKhau=@mahokhau , MaDoiTuong=@madoituong , MaDanToc=@madantoc , Toan=@toan , Ly=@ly , 
			Hoa=@hoa , Sinh=@sinh , Van=@van , Su=@su , Dia=@dia , AnhVan=@anhvan
			where SBD=@sbd;
		end;
end
GO

if OBJECT_ID('DELETEHoSoThiSinh') is not null drop proc DELETEHoSoThiSinh;
go
--22. Xóa giá trị hồ sơ thí sinh đã chọn trong Bảng HỒ SƠ THÍ SINH
create proc DELETEHoSoThiSinh
@sbd varchar(10)
as
begin
	begin try
		begin tran
			Delete NGUYENVONG where SBD=@sbd;
			Delete HOSOTHISINH where SBD=@sbd;
		commit tran
	end try
	begin catch
		rollback tran;
		throw 5000,'Lỗi r',1;
	end catch
end

go
--Bảng NGUYỆN VỌNG--
If OBJECT_ID('LOADNguyenVong') is not null drop proc LOADNguyenVong
go
--23. Load dữ liệu từ bảng NGUYỆN VỌNG vào datagridView.
create proc LOADNguyenVong
as
begin
	select NGUYENVONG.SBD,(HoDem+' '+Ten) as HoTen, TenNganh, Khoi,NguyenVong
	from (NGUYENVONG	join HOSOTHISINH on NGUYENVONG.SBD=HOSOTHISINH.SBD)
						join NGANH on NGUYENVONG.MaNganh=NGANH.MaNganh
	order by cast(NGUYENVONG.SBD as int) asc,NguyenVong asc,Khoi asc, TenNganh asc
end;
go

if OBJECT_ID('INSERTNguyenVong') is not null drop proc INSERTNguyenVong;
go
--24. Thêm giá trị nguyện vọng vào bảng NGUYỆN VỌNG. Sử dụng trigger để làm.
create proc INSERTNguyenVong
@sbd varchar(10),@tennganh varchar(50),@khoi varchar(50),@nguyenvong int
as
	declare @manganh int
	select @manganh=MaNganh
	from NGANH
	where TenNganh=@tennganh

	Insert NGUYENVONG (SBD,MaNganh,Khoi,NguyenVong)
	values(@sbd,@manganh,@khoi,@nguyenvong)
go
-----------------------------Index--------------------------------------------
create nonclustered index idx_ncc_NGANH_TenNganh
on NGANH(TenNganh)
include (MaNganh);
go
------------------------------------------------------------------------------
if OBJECT_ID('EDITNguyenVong') is not null drop proc EDITNguyenVong
go
--25. Sửa giá trị nguyện vọng đã chọn trong bảng NGUYỆN VỌNG. Sử dụng trigger để làm.
create proc EDITNguyenVong
@sbd varchar(10),
@tennganh varchar(50),
@khoi varchar(50),
@nguyenvong int
as
begin
	declare @manganh varchar(50)
	
	select @manganh=MaNganh
	from NGANH
	where TenNganh=@tennganh;

	Update NGUYENVONG set MaNganh=@manganh,Khoi=@khoi,NguyenVong=@nguyenvong where SBD=@sbd
end;



if OBJECT_ID('DELETENguyenVong') is not null drop proc DELETENguyenVong
go
--26. Xóa giá trị nguyện vọng đã chọn trong bảng NGUYỆN VỌNG.
create proc DELETENguyenVong
@sbd varchar(10),
@tennganh varchar(50),
@khoi varchar(50),
@nguyenvong int
as
begin
	declare @manganh int
	select @manganh=MaNganh
	from NGANH
	where TenNganh=@tennganh;

	Delete NGUYENVONG where SBD=@sbd and MaNganh=@manganh and Khoi=@khoi and NguyenVong=@nguyenvong;
end;
go
--Bảng đặc biệt--
if OBJECT_ID('LOADTraCuuDiem') is not null drop proc LOADTraCuuDiem;
go
--27. Load Dữ liệu Nguyện Vọng vào visual.
create proc LOADTraCuuDiem
@sbd varchar(10),
@ten varchar(50)
as
begin
	select NGUYENVONG.SBD,(HoDem+' '+Ten) as HoTen,NguyenVong,Khoi,NGUYENVONG.MaNganh,TenNganh,DiemTB,DanhGia
	from ((NGUYENVONG	join HOSOTHISINH on NGUYENVONG.SBD=HOSOTHISINH.SBD) 
						join NGANH on NGUYENVONG.MaNganh=NGANH.MaNganh)
	where  Ten like @ten+'%' and NGUYENVONG.SBD like @sbd+'%'
	order by Ten  asc, cast(HOSOTHISINH.SBD as int) asc;
end;
go

if OBJECT_ID('LOADTraCuuNganh') is not null drop proc LOADTraCuuNganh
go
--28. Load dữ liệu Ngành vào visual.
create proc LOADTraCuuNganh
@tennganh varchar(50)
as
begin
	select *
	from NGANH
	where TenNganh like @tennganh+'%'
	order by TenNganh asc;
end;
go
------------------Index---------------------------
create nonclustered index icx_ncc_NGANH_TenNganhAll
on NGANH(TenNganh)
include(MaNganh,DiemChuan,ChiTieu);
--------------------------------------------------
if OBJECT_ID('LOADDanToc') is not null drop PROC LOADDanToc;
go
--29. Load dữ liệu DanToc vào visual
create PROC LOADDanToc
as
begin 
	select  MaDanToc,TenDanToc,DiemCongDToc
	from DANTOC
	order by MaDanToc asc;
end
go

if OBJECT_ID('LOADKhuVuc') is not null drop proc LOADKhuVuc;
go
--30. Load dữ liệu bảng KHU VỰC vào datagridView
create proc LOADKhuVuc
as
begin
	select MaKhuVuc,TenKhuVuc,DiemCongKV
	from KHUVUC
end
go

if OBJECT_ID('LOADdataKHUVUC') is not null drop proc LOADdataKHUVUC
go
--31. Load dữ liệu bảng KHUVUc join HOKHAU
create proc LOADdataKHUVUC
as
begin
	select TenHuyen,TenTinh,TenKhuVuc
	from KHUVUC join HOKHAU on KHUVUC.MaKhuVuc=HOKHAU.MaKhuVuc
	order by TenTinh asc,HOKHAU.MaKhuVuc asc, TenHuyen asc;
end;
go

if OBJECT_ID('SEARCHKhuVuc') is not null drop proc SEARCHKhuVuc
go
--32. Search dữ liệu theo Khu vuc
create proc SEARCHKhuVuc
@khuvuc varchar(50)
as
begin
	select TenHuyen,TenTinh,TenKhuVuc
	from KHUVUC join HOKHAU on KHUVUC.MaKhuVuc=HOKHAU.MaKhuVuc
	where TenKhuVuc=@khuvuc
	order by TenTinh asc,TenHuyen asc;
end;
go
-------------------Index------------------------
create nonclustered index idx_ncc_HOKHAU_MaKhuVuc
on HOKHAU(MaKhuVuc)
include(TenTinh,TenHuyen);
go
--------------------------------------FUNCTION----------------------------------------


if OBJECT_ID('Fn_nganh') is not null drop function Fn_nganh
go
--Load dữ liệu ngành vào visual.
create function Fn_nganh()
returns table return
	select MaNganh, TenNganh, ChiTieu, DiemChuan
	from NGANH
	--order by TenNganh asc;
go 

if OBJECT_ID('fnCheckDiem') is not null drop function fnCheckDiem
go
--Kiểm tra điều kiện đánh giá nguyện vọng
create function fnCheckDiem(@diemTB float,@manganh int)
returns varchar(50)
begin
	return (select 'True'
			from NGANH
			where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan)
end;
go

--------------------------------------TRIGGER-----------------------------------

if OBJECT_ID('TriggerInsertNguyenVong') is not null drop trigger TriggerInsertNguyenVong;
go
--Thực hiện chức năng insert nguyện vọng.
create trigger TriggerInsertNguyenVong
on NGUYENVONG
instead of Insert
as
declare @sbd varchar(10),@manganh varchar(50),@khoi varchar(10),@nguyenvong int,
		@diemTB float,@danhgia varchar(50),@TestRowCount int;
select	@TestRowCount=COUNT(*) from inserted;
if @TestRowCount=1
	begin
		select @sbd=SBD,@manganh=MaNganh,@khoi=Khoi,@nguyenvong=NguyenVong
		from inserted;
		if(@sbd is not null and @manganh is not null and @khoi is not null and @nguyenvong is not null)
		begin
			if(@khoi=N'A')
			begin
				select @diemTB=Toan+Ly+Hoa
				from HOSOTHISINH
				where SBD=@sbd;
				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Insert NGUYENVONG (SBD,MaNganh,Khoi,NguyenVong,DiemTB,DanhGia)
					values(@sbd,@manganh,@khoi,@nguyenvong,@diemTB,@danhgia)
				end;
			end;
		else
			if(@khoi=N'A1')
			begin
				select @diemTB=Toan+Ly+AnhVan
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Insert NGUYENVONG (SBD,MaNganh,Khoi,NguyenVong,DiemTB,DanhGia)
					values(@sbd,@manganh,@khoi,@nguyenvong,@diemTB,@danhgia)
				end;
			end;
			else
			if(@khoi=N'B')
			begin
				select @diemTB=Toan+Hoa+Sinh
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Insert NGUYENVONG (SBD,MaNganh,Khoi,NguyenVong,DiemTB,DanhGia)
					values(@sbd,@manganh,@khoi,@nguyenvong,@diemTB,@danhgia)
				end;
			end;
			else
			if(@khoi=N'C')
			begin
				select @diemTB=Van+Su+Dia
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Insert NGUYENVONG (SBD,MaNganh,Khoi,NguyenVong,DiemTB,DanhGia)
					values(@sbd,@manganh,@khoi,@nguyenvong,@diemTB,@danhgia)
				end;
			end;
			else
			if(@khoi=N'D')
			begin
				select @diemTB=Toan+Van+AnhVan
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Insert NGUYENVONG (SBD,MaNganh,Khoi,NguyenVong,DiemTB,DanhGia)
					values(@sbd,@manganh,@khoi,@nguyenvong,@diemTB,@danhgia)
				end;
			end;
			else
			throw 5000,'Lỗi khối',1;
		end;
		else
		throw 5000,'Lỗi không có dữ liệu từ 4 biến',1;
	end;
else
	throw 5000,'Bạn bị lỗi insert Nguyện Vọng',1;
go

if OBJECT_ID('TriggerUpdateNguyenVong') is not null drop trigger TriggerUpdateNguyenVong;
go
--Thực hiện chức năng sửa nguyện vọng.
create trigger TriggerUpdateNguyenVong
on NGUYENVONG
after Update
as
declare @sbd varchar(10),@manganh varchar(50),@khoi varchar(10),@nguyenvong int,
		@diemTB float,@danhgia varchar(50),@TestRowCount int;
select	@TestRowCount=COUNT(*) from inserted;
if @TestRowCount=1
begin
	select @sbd=SBD,@manganh=MaNganh,@khoi=Khoi,@nguyenvong=NguyenVong
	from inserted;
	if(@sbd is not null and @manganh is not null and @khoi is not null and @nguyenvong is not null)
		begin
			if(@khoi=N'A')
			begin
				select @diemTB=Toan+Ly+Hoa
				from HOSOTHISINH
				where SBD=@sbd;
				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Update NGUYENVONG set DiemTB=@diemTB,DanhGia=@danhgia where SBD=@sbd and MaNganh=@manganh and Khoi=@khoi
				end;
			end;
		else
			if(@khoi=N'A1')
			begin
				select @diemTB=Toan+Ly+AnhVan
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Update NGUYENVONG set DiemTB=@diemTB,DanhGia=@danhgia where SBD=@sbd and MaNganh=@manganh and Khoi=@khoi
				end;
			end;
			else
			if(@khoi=N'B')
			begin
				select @diemTB=Toan+Hoa+Sinh
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Update NGUYENVONG set DiemTB=@diemTB,DanhGia=@danhgia where SBD=@sbd and MaNganh=@manganh and Khoi=@khoi
				end;
			end;
			else
			if(@khoi=N'C')
			begin
				select @diemTB=Van+Su+Dia
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Update NGUYENVONG set DiemTB=@diemTB,DanhGia=@danhgia where SBD=@sbd and MaNganh=@manganh and Khoi=@khoi
				end;
			end;
			else
			if(@khoi=N'D')
			begin
				select @diemTB=Toan+Van+AnhVan
				from HOSOTHISINH
				where SBD=@sbd;

				if(@diemTB>=0)
				begin
					--print'vao dung diem';
					--select @danhgia='True'
					--from NGANH
					--where NGANH.MaNganh=@manganh and @diemTB>NGANH.DiemChuan;
					set @danhgia=dbo.fnCheckDiem(@diemTB,@manganh);

					--select @danhgia;
					Update NGUYENVONG set DiemTB=@diemTB,DanhGia=@danhgia where SBD=@sbd and MaNganh=@manganh and Khoi=@khoi
				end;
			end;
			else
			throw 5000,'Lỗi khối',1;
		end;
		else
		throw 5000,'Lỗi không có dữ liệu từ 4 biến',1;
end;
else
	throw 5000,'Loi',1;

go

--Tool Index---
set statistics io, time on;
go

checkpoint;
dbcc dropcleanbuffers;

dbcc traceon(652, -1);