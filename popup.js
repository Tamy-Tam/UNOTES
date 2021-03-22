function listenClick() {
  const button = document.getElementById('send-data');
  button.addEventListener('click', () => {
    chrome.tabs.executeScript({
      file: 'scripts/send-data.js'
    });
  })
}

listenClick();
