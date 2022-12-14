const baseUrl = "https://groupware57.hanbiro.net";
const loginUrl = "$baseUrl/ngw/sign/auth?is_checking_otp=1";
// const getFolderUrl = "$baseUrl/cloud/api/get.php?access=1&type=dir";

String getFolderUrl(String type, String id) {
  return "$baseUrl/cloud/api/get.php?type=$type&id=$id";
}
