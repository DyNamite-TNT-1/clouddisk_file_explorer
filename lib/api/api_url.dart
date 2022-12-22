const baseUrl = "https://groupware57.hanbiro.net";
const loginUrl = "$baseUrl/ngw/sign/auth?is_checking_otp=1";

String getFolderUrl(String type, String id) {
  return "$baseUrl/cloud/api/get.php?type=$type&id=$id";
}

String sortFolderUrl(String type, String id, String sort, String order) {
  return "$baseUrl/cloud/api/get.php?type=$type&id=$id&sort=[{\"sort\":\"$sort\",\"order\":\"$order\"}]";
}
