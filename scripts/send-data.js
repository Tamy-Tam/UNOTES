function fetchData() {
  const title = document.querySelector('title').innerText;
  const url = window.location.href;

  return {
    title: title,
    url: url
  }
}

function sendData(data) {
  const url = 'http://localhost:3000/ycourses/new';
  window.open(url);
  fetch(url, {
    method: 'POST',
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      ycourse.url: `${data.url}`
    })
  })
}

sendData(fetchData());
