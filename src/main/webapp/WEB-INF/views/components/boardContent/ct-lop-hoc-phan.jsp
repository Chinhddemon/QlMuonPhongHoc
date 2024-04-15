<!-- 
	Dữ liệu tiếp nhận:
		URL:
			Paths:
				Usecase         -   Usecase sử dụng
				UsecasePath     -   UsecasePath sử dụng
			Params:
				IdLHP            -   Id lớp học
		Controller:
			NextUsecaseTable       -   Usecase chuyển tiếp trong table
			NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
			CTLopHocPhan
		SessionStorage:
			UIDManager
			UIDRegular
Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?IdLHP=${IdLHP}
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<title>Thông tin mượn phòng học</title>
	<c:forEach var="LopHocPhanRoot" items="${CTLopHocPhan.lopHocPhanSections}"><c:if test="${LopHocPhanRoot.nhomToAsString == '255'}">
		<c:set var="CTLopHocPhanRoot" value="${LopHocPhanRoot}" />
	</c:if></c:forEach>
	<c:if test="${IdSection != ''}">
		<c:forEach var="LopHocPhanSection" items="${CTLopHocPhan.lopHocPhanSections}"><c:if test="${LopHocPhanSection.idLHPSection == IdSection}">
			<c:set var="CTLopHocPhanSection" value="${LopHocPhanSection}" />
		</c:if></c:forEach>
	</c:if>
	<style>
		/* MARK: STYLE */
		@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;400&family=Roboto:wght@300;400;500;700&display=swap');

		/* html custom */
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			text-decoration: none;
			border: none;
			outline: none;
			font-size: 1rem;
			scroll-behavior: smooth;
			font-family: 'Poppins', sans-serif;
		}

		/* util */
		*.hidden {
			display: none;
		}

		:root {
			--bg-color: #f1dc9c;
			--second-bg-color: #fcf0cf30;
			--text-color: #555453;
			--text-box-color: #fcdec9;
			--main-color: #f3e0a7;
			--main-box-color: rgba(0, 0, 0, .7);
			--content-box-color: #b9b4a3;
			--admin-menu-color: #e9b4b4;
			--manager-menu-color: #ffda72;
			--regular-menu-color: #87e9e9;
		}

		html {
			font-size: 62.5%;
			overflow-x: hidden;
		}

		body {
			width: 100%;
			min-height: 100vh;
			background: var(--second-bg-color);
			display: flex;
			flex-direction: column;
			color: var(--text-color);
		}

		/* MARK: boardBar design */
		nav {
			background: var(--bg-color);
			display: flex;
			flex-shrink: 0;
			justify-content: space-between;
			align-items: center;
			box-shadow: 1px 1px 2px black;
			padding: 1.5rem 4rem;
			gap: 4rem;
			overflow: hidden;

			a {
				background: transparent;
				font-weight: 500;
				color: var(--text-color);
				cursor: pointer;
			}

			h2 {
				flex-grow: 1;
				margin: 0 2rem;
			}

			button {
				background: transparent;
				font-weight: 500;
				color: var(--text-color);
				cursor: pointer;
			}
		}

		nav.menu-manager {
			background: var(--manager-menu-color);
		}

		nav.menu-regular {
			background: var(--regular-menu-color);
		}

		nav.menu-admin {
			background: var(--admin-menu-color);
		}

		/* MARK: boardContent design */
		main {
			flex-grow: 1;
			width: 100%;
			height: 100%;
			display: flex;
			justify-content: center;
			align-items: center;

			form {
				width: 75rem;
				min-width: 50rem;
				background: var(--main-color);
				display: flex;
				flex-direction: column;
				justify-content: space-around;
				align-items: start;
				border: .2rem solid var(--main-box-color);
				border-radius: 2.5rem;
				margin: 1rem;
				box-shadow: 1px 1px 2px black;
				overflow: hidden;
				
				legend {
					align-self: center;
					padding-bottom: 2rem;
				}

				label {
					width: 100%;
					height: 100%;
					display: flex;
					justify-content: center;
					align-items: center;
					gap: 1rem;
					padding-top: .6rem;

					span {
						flex-grow: 1;
					}

					input,
					select {
						flex-grow: 1;
						text-align: end;
						border-right: .2rem solid var(--main-box-color);
						border-bottom: .3rem solid var(--main-box-color);
						border-radius: 1rem;
						padding: .5rem;
						opacity: .7;
						appearance: none;
					}

					input:disabled,
					select:disabled {
						background: transparent;
						border: none;
						opacity: 1;
					}
				}

				label.PhongHoc {
					span {
						flex-grow: 100;
					}
				}

				label.GiangVien {
					border-top: solid .2rem var(--content-box-color);
				}

				label.XacNhan {
					max-width: 85%;
					align-self: center;

					input {
						max-width: 7rem;
						box-shadow: .1rem 0 .7rem var(--main-box-color);
						font-weight: 700;
						text-align: center;
						transition: 2s;
					}

					input:valid {
						background-color: var(--text-color);
					}
				}

				div {
					width: 100%;
					height: 100%;
					display: flex;
					justify-content: space-around;
					align-items: center;
					margin-top: .4rem;
					gap: 3rem;
				}

				div.add-layout,
				div.remove-layout {
					justify-content: center;
					align-items: center;
				}

				/* util */
				div.innocent {
					flex-direction: inherit;
					justify-content: inherit;
					align-items: inherit;
					gap: 0;
					padding: 0;
					margin: 0;
					overflow: inherit;
				}

				button {
					cursor: pointer;
					border: .2rem solid black;
					border-radius: .5rem;
					padding: .4rem;
					transition: .1s;
				}

				button:hover {
					background-color: var(--text-box-color);
					border-radius: 1rem;
				}
			}
		}
		/* MARK: Media */
		@media only screen and (width <=768px) {

			/* Small devices (portrait tablets and large phones, 600px and up to 768px) */
			/* media boardBar design */
			nav {

				a,
				button {
					font-size: 1rem;
				}

				h2 {
					font-size: 1.3rem;
				}
			}

			/* media boardContent design */
			main form {
				padding: 6rem 8rem;

				legend {
					font-size: 2rem;
				}

				label {
					span {
						font-size: 1.3rem;
						font-weight: 600;
					}

					input,
					button,
					select {
						font-size: 1.3rem;
					}
				}

				button {
					font-size: 1rem;
				}
			}
		}

		@media only screen and (768px < width) {

			/* Medium devices (landscape tablets, 768px and up) */
			/* media boardBar design */
			nav {

				a,
				button {
					font-size: 1.4rem;
				}

				h2 {
					font-size: 1.8rem;
				}
			}

			/* media boardContent design */
			main form {
				padding: 6rem 12rem;

				legend {
					font-size: 2.5rem;
				}

				label {
					span {
						font-size: 1.5rem;
						font-weight: 600;
					}

					input,
					button,
					select {
						font-size: 1.5rem;
					}
				}

				button {
					font-size: 1.3rem;
				}
			}
		}
	</style>
	<script>
		// MARK: SCRIPT
		// Lấy địa chỉ URL hiện tại
		var url = window.location.href;

		let urlParts = url.split('?');
		// Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
		let paths = urlParts[0].replace(/\.htm$/, '').split('/');
		let params = new URLSearchParams(urlParts[1]);

		// Lấy thông tin từ paths urls
		var Usecase = paths[paths.length - 2];
		var UsecasePath = paths[paths.length - 1];

		// Lấy giá trị của các tham số từ sessionScope
		var UIDManager = sessionStorage.getItem('UIDManager');
		var UIDRegular = sessionStorage.getItem('UIDRegular');
		var UIDAdmin = sessionStorage.getItem('UIDAdmin');

		// In ra console để kiểm tra
		//console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
		//console.log(SearchInput, SearchOption)

		// MARK: setUsecases
		function setUsecases() {

			if (UIDManager && UIDRegular) {
				window.location.href = "../Error.htm?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
			}
			// Trường hợp người sử dụng là quản lý MARK: Manager
			else if (UIDManager) {

				// Trường hợp xem thông tin lớp học MARK: XemTTLHP
				if (Usecase === 'CTLHP' && UsecasePath === 'XemTTLHP') {

					// Ẩn các phần tử label và div trong form
					document.querySelector('.board-content div.add-layout').classList.add("hidden");
					document.querySelector('.board-content div.remove-layout').classList.add("hidden");
					if ('${CTLopHocPhanSection}' == '') {
						document.querySelector('.board-content div.innocent.LHP-Section').classList.add("hidden");
					}
					
					document.querySelector('.board-content label.XacNhan').classList.add("hidden");
					document.querySelector('.board-content div.submit').classList.add("hidden");
					

					// Ẩn các phần tử button trong form
					document.querySelector('.board-content .cancel-object').classList.add("hidden");
					document.querySelector('.board-content .conform-object').classList.add("hidden");
					document.querySelector('.board-content .submit-object').classList.add("hidden");

					// Chỉnh sửa phần tử nav theo Usecase
					document.querySelector('.board-bar').classList.add("menu-manager");

					// Chỉnh sửa nội dung của các thẻ trong nav
					document.querySelector('.board-bar h2.title').textContent = "Mã học phần: ${CTLopHocPhan.idNHP}${IdSection}";

					// Hiện các phần tử button trong nav
					document.querySelector('.board-bar .update-object').classList.remove("hidden");
					document.querySelector('.board-bar .remove-object').classList.remove("hidden");

				}
				// Trường hợp chỉnh sửa thông tin lớp học MARK: SuaTTLHP
				else if (Usecase === 'CTLHP' && UsecasePath === 'SuaTTLHP') {

					// Ẩn các phần tử label và div trong form
					if ('${CTLopHocPhanSection}' != '') {
						document.querySelector('.board-content div.add-layout').classList.add("hidden");
					} else {
						document.querySelector('.board-content div.innocent.LHP-Section').classList.add("hidden");
						document.querySelector('.board-content div.remove-layout').classList.add("hidden");
					}

					// Ẩn các phần tử button trong nav
					document.querySelector('.board-bar .update-object').classList.add("hidden");
					document.querySelector('.board-bar .remove-object').classList.add("hidden");

					// Ẩn các phần tử button trong form
					document.querySelector('.board-content .submit-object').classList.add("hidden");

					// Chỉnh sửa phần tử nav theo Usecase
					document.querySelector('.board-bar').classList.add("menu-manager");

					// Chỉnh sửa nội dung của các thẻ trong nav
					document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa học phần với mã: ${CTLopHocPhan.idNHP}${IdSection}";

					// Bỏ thuộc tính disabled của các phần tử
					document.querySelector('.board-content .MonHoc select').removeAttribute('disabled');
					document.querySelector('.board-content .NhomTo input.Nhom').removeAttribute('disabled');
					document.querySelector('.board-content .NhomTo input.To').removeAttribute('disabled');
					document.querySelector('.board-content .LopSV select').removeAttribute('disabled');
					document.querySelector('.board-content .GiangVien.LHP-Root select').removeAttribute('disabled');
					document.querySelector('.board-content .MucDich.LHP-Root select').removeAttribute('disabled');
					document.querySelector('.board-content .Ngay_BD.LHP-Root input').removeAttribute('disabled');
					document.querySelector('.board-content .Ngay_KT.LHP-Root input').removeAttribute('disabled');
					if ('${CTLopHocPhanSection}' != '') {
						document.querySelector('.board-content .GiangVien.LHP-Section select').removeAttribute('disabled');
						document.querySelector('.board-content .MucDich.LHP-Section select').removeAttribute('disabled');
						document.querySelector('.board-content .Ngay_BD.LHP-Section input').removeAttribute('disabled');
						document.querySelector('.board-content .Ngay_KT.LHP-Section input').removeAttribute('disabled');
					}
					document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');

				}
				// Trường hợp thêm thông tin lớp học MARK: ThemTTLHP
				else if (Usecase === 'CTLHP' && UsecasePath === 'ThemTTLHP') {

					// Ẩn các phần tử label và div trong form
					document.querySelector('.board-content div.innocent.LHP-Section').classList.add("hidden");
					document.querySelector('.board-content div.remove-layout').classList.add("hidden");

					// Ẩn các phần tử button trong nav
					document.querySelector('.board-bar button.update-object').classList.add("hidden");
					document.querySelector('.board-bar button.remove-object').classList.add("hidden");

					// Ẩn các phần tử button trong form
					document.querySelector('.board-content .submit-object').classList.add("hidden");

					// Chỉnh sửa phần tử nav theo Usecase
					document.querySelector('.board-bar').classList.add("menu-manager");

					// Chỉnh sửa nội dung của các thẻ trong nav
					document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa học phần với mã: ${CTLopHocPhan.idNHP}${IdSection}";

					// Bỏ thuộc tính disabled của các phần tử
					document.querySelector('.board-content .MonHoc select').removeAttribute('disabled');
					document.querySelector('.board-content .NhomTo input.Nhom').removeAttribute('disabled');
					document.querySelector('.board-content .NhomTo input.To').removeAttribute('disabled');
					document.querySelector('.board-content .LopSV select').removeAttribute('disabled');
					document.querySelector('.board-content .GiangVien.LHP-Root select').removeAttribute('disabled');
					document.querySelector('.board-content .MucDich.LHP-Root select').removeAttribute('disabled');
					document.querySelector('.board-content .Ngay_BD.LHP-Root input').removeAttribute('disabled');
					document.querySelector('.board-content .Ngay_KT.LHP-Root input').removeAttribute('disabled');
					document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');

				}
				else {  //Xử lý lỗi ngoại lệ truy cập
					window.location.href = "../Error.htm?Message= Lỗi UID hoặc Usecase không tìm thấy";
				}

			}
			else {  // Không phát hiện mã UID
				window.location.href = "../Login.htm?Message=Không phát hiện mã UID";
			}
		}
		// MARK: setFormValues
		function setFormValues() {

			// Đặt giá trị cho các thẻ select trong form
			document.querySelector('.board-content .MonHoc select').value = '${CTLopHocPhan.monHoc.maMH}';
			document.querySelector('.board-content .LopSV select').value = '${CTLopHocPhan.lopSV.maLopSV}';
			document.querySelector('.board-content .GiangVien.LHP-Root select').value = '${CTLopHocPhanRoot.giangVien.maGV}';
			document.querySelector('.board-content .MucDich.LHP-Root select').value = '${CTLopHocPhanRoot.mucDich}';
			if ('${CTLopHocPhanSection}' !== '') {
				document.querySelector('.board-content .GiangVien.LHP-Section select').value = '${CTLopHocPhanSection.giangVien.maGV}';
				document.querySelector('.board-content .MucDich.LHP-Section select').value = '${CTLopHocPhanSection.mucDich}';
			}

			// Đặt giá trị cho các thẻ button trong form
			var tableLink1 = document.getElementById("option-one-id-${CTLichMPH.idLMPH}");
			tableLink1.setAttribute("formaction", "../${NextUsecaseSubmitOption1}/${NextUsecasePathSubmitOption1}.htm?IdLHP=${CTLopHocPhan.idNHP}${IdSection}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
			var tableLink2 = document.getElementById("option-two-id-${CTLichMPH.idLMPH}");
			tableLink2.setAttribute("formaction", "../${NextUsecaseSubmitOption2}/${NextUsecasePathSubmitOption2}.htm?IdLHP=${CTLopHocPhan.idNHP}${IdSection}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
			
		}

		// MARK: event functions
		function modifyToUpdateData() {

			// Thay đổi path thứ hai thành 'DSMPH'
			paths[paths.length - 1] = 'SuaTTLHP';

			// Tạo URL mới từ các phần tử đã thay đổi
			let newURL = paths.join('/') + '.htm' + '?' + params.toString();

			window.location.href = newURL;
		}
		function modifyToDeleteData() {

		}
		function addLHPSection() {
			document.querySelector('.board-content .GiangVien.LHP-Section select').removeAttribute('disabled');
			document.querySelector('.board-content .MucDich.LHP-Section select').removeAttribute('disabled');
			document.querySelector('.board-content .Ngay_BD.LHP-Section input').removeAttribute('disabled');
			document.querySelector('.board-content .Ngay_KT.LHP-Section input').removeAttribute('disabled');
			document.querySelector('.innocent').classList.remove("hidden");
			document.querySelector('.add-layout').classList.add("hidden");
			document.querySelector('.remove-layout').classList.remove("hidden");
		}
		function removeLHPSection() {
			document.querySelector('.board-content .GiangVien.LHP-Section select').setAttribute('disabled', 'disabled');
			document.querySelector('.board-content .MucDich.LHP-Section select').setAttribute('disabled', 'disabled');
			document.querySelector('.board-content .Ngay_BD.LHP-Section input').setAttribute('disabled', 'disabled');
			document.querySelector('.board-content .Ngay_KT.LHP-Section input').setAttribute('disabled', 'disabled');
			document.querySelector('.innocent').classList.add("hidden");
			document.querySelector('.add-layout').classList.remove("hidden");
			document.querySelector('.remove-layout').classList.add("hidden");
		}

		// MARK: DOMContentLoaded
		// Gọi hàm khi trang được load
		document.addEventListener("DOMContentLoaded", function () {
			setUsecases();
			setFormValues();
		});
	</script>
</head>

<body>
	<!-- MARK: Boardbar -->
	<nav class="board-bar">
		<a class="go-back" href="#" onclick="history.back();">Quay lại</a>
		<h2 class="title">SomeThingError!</h2>
		<button class="update-object hidden" onclick="modifyToUpdateData()">Chỉnh sửa</button>
		<button class="remove-object hidden" onclick="">Xóa</button>
	</nav>
	<!-- MARK: Boardcontent -->
	<main>
		<form class="board-content">
			<legend>Thông tin lớp học</legend>
			<label class="MonHoc">
				<span>Môn học: </span>
				<select disabled required name="MaMH">
					<option disabled selected hidden 
						value="">
						Chọn môn học
					</option>
					<c:choose>
						<c:when test="${DsMonHoc != null}">
							<c:forEach var="MonHoc" items="${DsMonHoc}">
								<option 
									value="${MonHoc.maMH}">
									${MonHoc.maMH} - ${MonHoc.tenMH}
								</option>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<option disabled selected hidden
								value="${CTLopHocPhan.monHoc.maMH}">
								${CTLopHocPhan.monHoc.maMH} - ${CTLopHocPhan.monHoc.tenMH}
							</option>
						</c:otherwise>
					</c:choose>
				</select>
			</label>
			<label class="NhomTo">
				<span>Nhóm tổ: </span>
				<c:if test="${NextUsecaseSubmitOption1 == null && NextUsecasePathSubmitOption1 == null 
										&& NextUsecaseSubmitOption2 == null && NextUsecasePathSubmitOption2 == null}">
					<c:if test="${CTLopHocPhan != null && (CTLopHocPhanSection == null || CTLopHocPhanSection.nhomToAsString == '00')}">
						<input type="text" disabled
							value="${CTLopHocPhan.nhomAsString}">
					</c:if>
					<c:if test="${CTLopHocPhanSection != null && CTLopHocPhanSection.nhomToAsString != '00' && CTLopHocPhanSection.nhomToAsString != '255'}">
						<input type="text" disabled
							value="${CTLopHocPhan.nhomAsString}-${CTLopHocPhanSection.nhomToAsString}">
					</c:if>
				</c:if>
				<c:if test="${NextUsecaseSubmitOption1 != null && NextUsecasePathSubmitOption1 != null 
					|| NextUsecaseSubmitOption2 != null && NextUsecasePathSubmitOption2 != null}">
					<input class="Nhom" type="text" disabled required style="max-width: 40px; text-align: center;"
						pattern="[0-9]{2}" maxlength="2" 
						name="Nhom"
						value="${CTLopHocPhan.nhomAsString}">
					<input class="To" type="text" disabled style="max-width: 40px; text-align: center;" 
						pattern="[0-9]" maxlength="2" placeholder=""
						name="To"
						value="${CTLopHocPhanSection.nhomToAsString == '00' ? '' : CTLopHocPhanSection.nhomToAsString}">
				</c:if>
			</label>
			<label class="LopSV">
				<span>Lớp giảng dạy: </span>
				<select disabled required 
					name="MaLopSV">
					<option disabled selected hidden 
						value="">
						Chọn lớp sinh viên
					</option>
					<c:choose>
						<c:when test="${DsLopSV != null}">
							<c:forEach var="LopSV" items="${DsLopSV}">
								<option 
									value="${LopSV.maLopSV}">
									${LopSV.maLopSV}
								</option>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<option disabled selected hidden 
								value="${CTLopHocPhan.lopSV.maLopSV}">
								${CTLopHocPhan.lopSV.maLopSV}
							</option>
						</c:otherwise>
					</c:choose>
				</select>
			</label>
			<!-- MARK: First Section -->
			<br>
			<label class="GiangVien LHP-Root">
				<span>Giảng viên: </span>
				<select disabled required 
					name="MaGV-Root">
					<option disabled selected hidden 
						value="">
						Chọn giảng viên
					</option>
					<c:choose>
						<c:when test="${DsGiangVien != null}">
							<c:forEach var="GiangVien" items="${DsGiangVien}">
								<option 
									value="${GiangVien.maGV}">
									${GiangVien.maGV} - ${GiangVien.ttNgMPH.hoTen}
								</option>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<option disabled selected hidden 
								value="${CTLopHocPhanRoot.giangVien.maGV}">
								${CTLopHocPhanRoot.giangVien.maGV} - ${CTLopHocPhanRoot.giangVien.ttNgMPH.hoTen}
							</option>
						</c:otherwise>
					</c:choose>
				</select>
			</label>
			<label class="MucDich LHP-Root">
				<span>Hình thức học: </span>
				<select disabled required name="MucDich-Root">
					<option disabled selected hidden 
						value="">
						Chọn hình thức
					</option>
					<option 
						value="LT">
						Lý thuyết
					</option>
					<option 
						value="TH">
						Thực hành
					</option>
					<option 
						value="TN">
						Thí nghiệm
					</option>
					<option 
						value="U">
						Khác
					</option>
				</select>
			</label>
			<label class="Ngay_BD LHP-Root">
				<span>Giai đoạn bắt đầu: </span>
				<input type="date" disabled required
					name="Ngay_BD-Root" 
					value="${CTLopHocPhanRoot.ngay_BD}">
			</label>
			<label class="Ngay_KT LHP-Root">
				<span>Giai đoạn kết thúc: </span>
				<input type="date" disabled required
					name="Ngay_KT-Root" 
					value="${CTLopHocPhanRoot.ngay_KT}">
			</label>
			<div class="add-layout LHP-Section">
				<button class="add-object LHP-Section" type="button" onclick="addLHPSection()">
					Thêm thông tin
				</button>
			</div>
			<div class="innocent LHP-Section">
				<!-- MARK: Second Section -->
				<br>
				<label class="GiangVien LHP-Section">
					<span>Giảng viên: </span>
					<select disabled required 
						name="MaGV-Section">
						<option disabled selected hidden 
							value="">
							Chọn giảng viên
						</option>
						<c:choose>
							<c:when test="${DsGiangVien != null}">
								<c:forEach var="GiangVien" items="${DsGiangVien}">
									<option 
										value="${GiangVien.maGV}">
										${GiangVien.maGV} - ${GiangVien.ttNgMPH.hoTen}
									</option>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<option disabled selected hidden
									value="${CTLopHocPhanSection.giangVien.maGV}">
									${CTLopHocPhanSection.giangVien.maGV} - ${CTLopHocPhanSection.giangVien.ttNgMPH.hoTen}
								</option>
							</c:otherwise>
						</c:choose>
					</select>
				</label>
				<label class="MucDich LHP-Section">
					<span>Hình thức học: </span>
					<select disabled required 
						name="MucDich-Section">
						<option disabled selected hidden 
							value="">
							Chọn hình thức
						</option>
						<option value="LT">
							Lý thuyết
						</option>
						<option value="TH">
							Thực hành
						</option>
						<option value="TN">
							Thí nghiệm
						</option>
						<option value="U">
							Khác
						</option>
					</select>
				</label>
				<label class="Ngay_BD LHP-Section">
					<span>Giai đoạn bắt đầu: </span>
					<input type="date" disabled required
						name="Ngay_BD-Section"
						value="${CTLopHocPhanSection.ngay_BD}">
				</label>
				<label class="Ngay_KT LHP-Section">
					<span>Giai đoạn kết thúc:</span>
					<input type="date" disabled required
						name="Ngay_KT-Section"
						value="${CTLopHocPhanSection.ngay_KT}">
				</label>
			</div>
			<div class="remove-layout LHP-Section">
				<button class="remove-object LHP-Section" type="button" onclick="removeLHPSection()">
					Lược bỏ thông tin
				</button>
			</div>
			<label class="QuanLyKhoiTao">
				<span>Quản lý tạo lớp học: </span>
				<input type="text" disabled
					value="${CTLopHocPhan.quanLyKhoiTao.maQL}${QuanLyKhoiTao.maQL} - ${CTLopHocPhan.quanLyKhoiTao.hoTen}${QuanLyKhoiTao.hoTen}" />
			</label>
			<label class="XacNhan">
				<span>Mã xác nhận: </span>
				<input type="text" disabled required name="XacNhan" />
			</label>
			<div class="submit">
				<button class="cancel-object" type="button" onclick="history.back()">
					Hủy bỏ
				</button>
				<button id="option-one-id-${CTLichMPH.idLMPH}" class="submit-object" type="submit"
					onclick="history.back();history.back();" formaction="#scriptSet"
					formmethod="post">
					Cập nhật
				</button>
				<button id="option-two-id-${CTLichMPH.idLMPH}" class="conform-object" type="submit"
					onclick="history.back();history.back();" formaction="#scriptSet"
					formmethod="post">
					Xác nhận
				</button>
			</div>
			<c:if test="${errorMessage != '' || errorMessage != null}">
				<p>${errorMessage}</p>
			</c:if>
		</form>
	</main>
</body>

</html>