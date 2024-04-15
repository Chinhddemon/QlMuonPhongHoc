<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<style>
	header {
		h2 {
			color: var(--text-color);
			font-weight: 600;
			user-select: none;
		}

		nav a {
			color: var(--text-color);
			font-weight: 400;
			margin-left: 3.5rem;
		}
	}

	@media only screen and (width <=992px) {

		/* Small devices (portrait tablets and large phones, 600px and up) */
		header {
			h2 {
				font-size: 2rem;
			}

			nav a {
				font-size: 1.5rem;
			}
		}
	}

	@media only screen and (992px < width) {

		/* Medium devices (landscape tablets, 992px and up) */
		header {
			h2 {
				font-size: 2.5rem;
			}

			nav a {
				font-size: 1.8rem;
			}
		}
	}
</style>
<script>
	function home() {
		history.back();
		window.location.href = "Login.htm?Command=Home" + "&uuid=" + UIDRegular + UIDManager + UIDAdmin;
	}
	function logout() {
		var UIDManager = sessionStorage.getItem("UIDManager");
		var UIDManager = sessionStorage.getItem("UIDManager");
		var UIDAdmin = sessionStorage.getItem("UIDAdmin");
		if (UIDManager) sessionStorage.removeItem("Token");
		if (UIDAdmin) sessionStorage.removeItem("TokenAdmin");
		sessionStorage.removeItem("UIDManager");
		sessionStorage.removeItem("UIDRegular");
		history.back();
		window.location.href = "Login.htm?Command=Logout" + "&uuid=" + UIDRegular + UIDManager + UIDAdmin;
	}
</script>
<h2>My PTIT</h2>
	<nav>
		<a onclick="home();" href="#">Home</a>
		<a href="#">About</a>
		<a href="#">Account</a>
		<a onclick="logout();" href="#">Logout</a>
	</nav>