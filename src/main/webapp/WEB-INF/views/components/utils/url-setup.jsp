<script id="url-setup">
  // Lấy địa chỉ URL hiện tại
  var url = window.location.href;

  let urlParts = url.split("?");

  let paths = urlParts[0].split('/');
  let params = new URLSearchParams(urlParts[1]);

  // Lấy thông tin từ params urls
  var SearchInput = params.get('SearchInput')
  var SearchOption = params.get('SearchOption')

  // Lấy thông tin từ paths urls
  var Usecase = paths[paths.length - 2];
  var UsecasePath = paths[paths.length - 1];

  // Lấy giá trị của các tham số từ sessionScope
  var UIDManager = sessionStorage.getItem("UIDManager");
  var UIDRegular = sessionStorage.getItem("UIDRegular");
  var UIDAdmin = sessionStorage.getItem("UIDAdmin");

  // In ra console để kiểm tra
  //console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
  //console.log(SearchInput, SearchOption)
</script>