String greeting() {
  var timeNow = DateTime.now().hour;
  if (timeNow < 10) {
    return 'Selamat Pagi';
  } else if ((timeNow >= 10) && (timeNow < 15)) {
    return 'Selamat Siang';
  } else if ((timeNow >= 15) && (timeNow < 18)) {
    return 'Selamat Sore';
  } else if ((timeNow >= 18) && (timeNow < 19)) {
    return 'Selamat Petang';
  } else {
    return 'Selamat Malam';
  }
}
