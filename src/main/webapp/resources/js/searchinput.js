function updatePlaceholder() {
  const placeholderDesktop = "영화제목, 배우 또는 감독을 검색하세요.";
  const placeholderMobile = "영화제목 검색!";

  const breakpoint = 768;

  if (window.innerWidth >= breakpoint) {
    document.getElementById("myInput").placeholder = placeholderDesktop;
  } else {
    document.getElementById("myInput").placeholder = placeholderMobile;
  }
}

window.addEventListener('DOMContentLoaded', updatePlaceholder);
window.addEventListener('resize', updatePlaceholder);
