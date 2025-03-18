<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html dir="ltr" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta
      name="keywords"
      content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Matrix lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Matrix admin lite design, Matrix admin lite dashboard bootstrap 5 dashboard template"
    />
    <meta
      name="description"
      content="Matrix Admin Lite Free Version is powerful and clean admin dashboard template, inpired from Bootstrap Framework"
    />
    <meta name="robots" content="noindex,nofollow" />
    <title>아티스트 멤버정보</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- Favicon icon 
    <link
      rel="icon"
      type="image/png"
      sizes="16x16"
      href="../assets/images/favicon.png"
    />
    -->
    <!-- Custom CSS -->
    <link
      rel="stylesheet"
      type="text/css"
      href="/css/multicheck.css"
    />
    <link
      href="/css/dataTables.bootstrap4.css"
      rel="stylesheet"
    />
    <link href="/css/style.min.css" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script>
		const deleteBtn = () =>{
			if(confirm("${amdto.artistmember_nickname}님을 삭제하시겠습니까?")){
				$.ajax({
					url:"/artistmemdelete",
					type:"post",	
					data:{"artistmember_nickname":"${amdto.artistmember_nickname}"},
					success:function(data){
						alert("회원정보를 삭제했습니다.");
						location.href="/aartist"
						console.log(data);
					},
					error:function(){
						alert("실패");
					}
				}); // ajax
			}
		}
		
	  	const readUrl = (input) => {
	  		if(input.files && input.files[0]){
	  			var reader = new FileReader();
	  			reader.onload = function(e){
	  				document.getElementById("preview").src = e.target.result;
	  			}
	  			reader.readAsDataURL(input.files[0]);
	  		}else{
	  				document.getElementById("preview").src = "";
	  		}
	  	}
	</script>
    <style>
    	.register-button {
    		width: 100px;
		    display: inline-block;
		    color: #7460ee;
		    text-decoration: none;
		    background-color: #fff;
		    border: 1px solid #dee2e6;
		    padding: 8px 16px;
		    font-size: 14px;
		    font-weight: bold;
		    border-radius: 4px;
		    transition: color 0.15s ease-in-out, 
		                background-color 0.15s ease-in-out, 
		                border-color 0.15s ease-in-out, 
		                box-shadow 0.15s ease-in-out;
		    cursor: pointer;
		}
		
		.register-button:hover {
		    background-color: #7460ee;
		    color: #fff;
		}
		.signup-form .row-inline {
	      display: flex;
	      align-items: center;
	      gap: 8px;
	    }
	    .signup-form .row-inline input[type="text"] {
	      flex: 1;
	    }

	    .btn-dup-check {
		      height: 30px;
		      padding: 0 12px;
		      background-color: #F5C3B2;
		      color: #fff;
		      border: none;
		      border-radius: 4px;
		      cursor: pointer;
		      font-size: 14px;
		      font-weight: 600;
		    }
		    .btn-dup-check:hover {
		 	  color: #F5C3B2;
		      background-color: #f5f5f5;
		    }
	
		    /* 국가 선택 예시 (번호 표시) */
		    .country-select {
		      width: 100%;
		      margin-top: 5px;
		    }
		
		    /* 숨김 처리 (artistmembership=0) */
		    input[type="hidden"] {
		      display: none;
		    }
		    .addressinput{
		    	width:400px;
		    	height: 30px;
		    }
    </style>
  </head>

  <body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
      <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
      </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div
      id="main-wrapper"
      data-layout="vertical"
      data-navbarbg="skin5"
      data-sidebartype="full"
      data-sidebar-position="absolute"
      data-header-position="absolute"
      data-boxed-layout="full"
    >
      <!-- ============================================================== -->
      <!-- Topbar header - style you can find in pages.scss -->
      <!-- ============================================================== -->
      <header class="topbar" data-navbarbg="skin5">
        <nav class="navbar top-navbar navbar-expand-md navbar-dark">
          <div class="navbar-header" data-logobg="skin5">
            <!-- ============================================================== -->
            <!-- Logo -->
            <!-- ============================================================== -->
            <a class="navbar-brand" href="/">
              <!-- Logo icon -->
              <b class="logo-icon ps-2">
                <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                <!-- Dark Logo icon -->
                <img
                  src="/images/tempLogo2.png"
                  alt="homepage"
                  class="light-logo"
                  width="80"
                />
              </b>
              <!--End Logo icon -->
              <!-- Logo text -->
                <!--
              <span class="logo-text ms-2">
                 dark Logo text 
                <img
                  src="../assets/images/logo-text.png"
                  alt="homepage"
                  class="light-logo"
                />
              </span>
                -->
              <!-- Logo icon -->
              <!-- <b class="logo-icon"> -->
              <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
              <!-- Dark Logo icon -->
              <!-- <img src="../assets/images/logo-text.png" alt="homepage" class="light-logo" /> -->

              <!-- </b> -->
              <!--End Logo icon -->
            </a>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Toggle which is visible on mobile only -->
            <!-- ============================================================== -->
            <a
              class="nav-toggler waves-effect waves-light d-block d-md-none"
              href="javascript:void(0)"
              ><i class="ti-menu ti-close"></i
            ></a>
          </div>
          <!-- ============================================================== -->
          <!-- End Logo -->
          <!-- ============================================================== -->
          <div
            class="navbar-collapse collapse"
            id="navbarSupportedContent"
            data-navbarbg="skin5"
          >
            <!-- ============================================================== -->
            <!-- Right side toggle and nav items -->
            <!-- ============================================================== -->
          </div>
        </nav>
      </header>
      <!-- ============================================================== -->
      <!-- End Topbar header -->
      <!-- ============================================================== -->
      <!-- ============================================================== -->
      <!-- Left Sidebar - style you can find in sidebar.scss  -->
      <!-- ============================================================== -->
      <aside class="left-sidebar" data-sidebarbg="skin5">
        <!-- Sidebar scroll-->
        <div class="scroll-sidebar">
          <!-- Sidebar navigation-->
          <nav class="sidebar-nav">
            <ul id="sidebarnav" class="pt-4">
              <li class="sidebar-item">
                <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/aartistlist"
                  aria-expanded="false"
                  ><i class="mdi mdi-view-dashboard"></i
                  ><span class="hide-menu">리스트 관리</span></a
                >
              </li>
              <li class="sidebar-item">
                <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/aartist"
                  aria-expanded="false"
                  ><i class="mdi mdi-view-dashboard"></i
                  ><span class="hide-menu">아티스트 관리</span></a
                >
              </li>
              <li class="sidebar-item">
                <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/admin"
                  aria-expanded="false"
                  ><i class="mdi mdi-view-dashboard"></i
                  ><span class="hide-menu">회원관리</span></a
                >
              </li>
              <li class="sidebar-item">
                <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/shop"
                  aria-expanded="false"
                  ><i class="mdi mdi-chart-bar"></i
                  ><span class="hide-menu">굿즈샵관리</span></a
                >
              </li>
              <li class="sidebar-item">
                <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/ticket"
                  aria-expanded="false"
                  ><i class="mdi mdi-chart-bar"></i
                  ><span class="hide-menu">티켓샵관리</span></a
                >
              </li>
              <li class="sidebar-item">
                <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/notice"
                  aria-expanded="false"
                  ><i class="mdi mdi-chart-bar"></i
                  ><span class="hide-menu">공지관리</span></a
                >
              </li>
              <li class="sidebar-item">
                <a
                  class="sidebar-link waves-effect waves-dark sidebar-link"
                  href="/event"
                  aria-expanded="false"
                  ><i class="mdi mdi-chart-bar"></i
                  ><span class="hide-menu">이벤트관리</span></a
                >
              </li>
            </ul>
          </nav>
          <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
      </aside>
      <!-- ============================================================== -->
      <!-- End Left Sidebar - style you can find in sidebar.scss  -->
      <!-- ============================================================== -->
      <!-- ============================================================== -->
      <!-- Page wrapper  -->
      <!-- ============================================================== -->
      <div class="page-wrapper">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="page-breadcrumb">
          <div class="row">
            <div class="col-12 d-flex no-block align-items-center">
              <h4 class="page-title">아티스트 멤버관리</h4>
              <div class="ms-auto text-end">
                <nav aria-label="breadcrumb">
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">메인페이지</a></li>
                    <li class="breadcrumb-item active" aria-current="/aartist">
                      아티스트 멤버관리
                    </li>
                  </ol>
                </nav>
              </div>
            </div>
          </div>
        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Container fluid  -->
        <!-- ============================================================== -->
        <div class="container-fluid">
          <!-- ============================================================== -->
          <!-- Start Page Content -->
          <!-- ============================================================== -->
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">아티스트 멤버정보</h5>
                  <div class="table-responsive">
                  	<form action="/artistmemupdate" method="post">
                    <table
                      id="zero_config"
                      class="table table-striped table-bordered"
                    >
                      <colgroup>
						  <col width="30%">
						  <col width="70%">
					  </colgroup>	
                      <tbody>
						<tr>
							<th>아이디</th>
							<td>${amdto.artistmember_id}</td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td><input type="password" name="artistmember_pw" value="${amdto.artistmember_pw}"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="artistmember_name" value="${amdto.artistmember_name}"></td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td><input type="text" name="artistmember_nickname" value="${amdto.artistmember_nickname}" readonly /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="email" name="artistmember_email" value="${amdto.artistmember_email}"></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>${amdto.artistmember_birth}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${amdto.artistmember_phone}</td>
						</tr>
						<tr>
							<th>성별</th>
							<td><input type="text" name="artistmember_gender" value="${amdto.artistmember_gender}"></td>
						</tr>
						<tr>
							<th><label for="artistmember_address">주소</label></th>
							<td><div class="row-inline">
								<input type="text" id="artistmember_postalCode" class="addressInput" name="artistmember_postalCode"
									placeholder="우편번호" style="width: 100px;" required /> 
								<input type="button" id="addAddressBtn"	class="btn-dup-check" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" required />
						    </div><br>
						    <br> <input type="text" class="addressinput" id="artistmember_address" placeholder="주소" required /><br><br>
					        <input type="text" class="addressinput" id="detailAddress" placeholder="상세주소" required /><br><br>
						    <input type="text" class="addressinput" id="sample6_extraAddress" placeholder="참고항목" />
						  
						    <input type="hidden" id="full_address" name="artistmember_address"/></td>
						</tr>
						<tr>
							<th><label for="artistmember_country">국가/지역</label></th>
							<td> 
								<select id="artistmember_country" name="artistmember_country" class="country-select" required>
							        <option value="대한민국">대한민국 (+82)</option>
							        <option value="일본">일본 (+81)</option>
							        <option value="미국">미국 (+1)</option>
							        <option value="중국">중국 (+86)</option>
						     	 </select>
					     	</td>
						</tr>
						<tr>
							<th>가입일</th>
							<td>${amdto.artistmember_date}</td>
						</tr>
						<tr>
							<th>이미지</th>
							<td>
								<input type="file" name="files" id="file" onchange="readUrl(this);">
							</td>
						</tr>
						<tr>
				  	        <th>이미지 보기</th>
				            <c:if test="${not empty amdto._file}">
					            <td>
								    <img id="preview" src="/upload/test/${edto.event_file}" alt="현재 이미지" style="width:1000px;">
					            </td>
							</c:if>
				            <c:if test="${empty edto.event_file}">
			                 	<td>
					            <img id="preview" style="width:1000px">
					            </td>
							</c:if>
				        </tr>
                      </tbody>
                      <tfoot>
						<button type="submit" class="register-button">수정</button>
                      </tfoot>
                    </table>
                    </form>
                      	<button onclick="deleteBtn()" class="register-button">삭제</button>
                      	<a href="/aartist"><button class="register-button">취소</button></a>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- ============================================================== -->
          <!-- End PAge Content -->
          <!-- ============================================================== -->
          <!-- ============================================================== -->
          <!-- Right sidebar -->
          <!-- ============================================================== -->
          <!-- .right-sidebar -->
          <!-- ============================================================== -->
          <!-- End Right sidebar -->
          <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script>
	    // 이메일 domain과 local 합쳐서 hidden input으로 전달
	    const emailLocal = document.getElementById('email_local');
	    const emailDomain = document.getElementById('email_domain');
	    const emailHidden = document.getElementById('artistmember_email');
	    function updateEmail() {
	      emailHidden.value = emailLocal.value + "@" + emailDomain.value;
	    }
	    emailLocal.addEventListener('input', updateEmail);
	    emailDomain.addEventListener('change', updateEmail);
	    
	    // 주소
	    function sample6_execDaumPostcode() {
	         new daum.Postcode({
	             oncomplete: function(data) {
	                 var addr = '';
	                 var extraAddr = '';
	                 if (data.userSelectedType === 'R') {
	                     addr = data.roadAddress;
	                 } else {
	                     addr = data.jibunAddress;
	                 }
	                 if(data.userSelectedType === 'R'){
	                     if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                         extraAddr += data.bname;
	                     }
	                     if(data.buildingName !== '' && data.apartment === 'Y'){
	                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                     }
	                     if(extraAddr !== ''){
	                         extraAddr = ' (' + extraAddr + ')';
	                     }
	                     document.getElementById("sample6_extraAddress").value = extraAddr;
	                 } else {
	                     document.getElementById("sample6_extraAddress").value = '';
	                 }
	                 document.getElementById('artistmember_postalCode').value = data.zonecode;
	                 document.getElementById("artistmember_address").value = addr;
	                 document.getElementById("detailAddress").focus();
	             }
	         }).open();
	     }
	     
	     function updateAddress() {
	    	  const mainAddress = document.getElementById("artistmember_address").value;
	    	  const detailAddress = document.getElementById("detailAddress").value;
	    	  
	    	  let fullAddress = mainAddress;
	    	  if(detailAddress){
	    		  fullAddress += " " + detailAddress;
	    	  }
	    	  
	    	  document.getElementById("full_address").value = fullAddress;
		 }
    </script>
    <script src="/js/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="/js/bootstrap.bundle.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="/js/perfect-scrollbar.jquery.min.js"></script>
    <script src="/js/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="/js/custom.min.js"></script>
    <!-- this page js -->
    <script src="/js/datatable-checkbox-init.js"></script>
    <script src="/js/jquery.multicheck.js"></script>
    <script src="/js/datatables.min.js"></script>
    <script>
      /****************************************
       *       Basic Table                   *
       ****************************************/
      $("#zero_config").DataTable();
    </script>
  </body>
</html>
