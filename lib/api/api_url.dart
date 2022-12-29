const baseUrl = "https://gw.hanbiro.vn";
const loginUrl = "$baseUrl/ngw/sign/auth";

String getFolderUrl(String type, String id) {
  return "$baseUrl/cloud/api/get.php?type=$type&id=$id";
}

String sortFolderUrl(String type, String id, String sort, String order) {
  return "$baseUrl/cloud/api/get.php?type=$type&id=$id&sort=[{\"sort\":\"$sort\",\"order\":\"$order\"}]";
}

String sendFileUrl(String files, String mode) {
  return "$baseUrl/cloud/api/link.php?files=$files&mode=$mode";
}
