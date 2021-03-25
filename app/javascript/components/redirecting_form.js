const redirecting = () => {
  const form = document.querySelector("#new_ycourse");
  if (form) {
    const urlInput = document.querySelector("#ycourse_url");
    if (urlInput.value) {
      setTimeout(() => {
        form.submit();
      }, 1500);
    } else {
      document.querySelector(".waiting").outerHTML = "";
      document.querySelector(".card-box").classList.remove("card-box-hidden");
    }
  }
}

export { redirecting };
