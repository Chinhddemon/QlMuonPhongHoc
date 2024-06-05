<style id="default">
  @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;400&family=Roboto:wght@300;400;500;700&display=swap');

  * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      text-decoration: none;
      border: none;
      outline: none;
      font-size: 1rem;
      transition: .2s;
      scroll-behavior: smooth;
      font-family: 'Poppins', sans-serif;
  }

  :root {
      --bg-color: #ffffffcf;
      --second-bg-color: rgb(255 242 229);
      --text-color: #71706E;
      --text-box-color: #ffebde;
      --main-color: #fff0c4;
      --main-box-color: rgb(36 36 36 / 70%);
      --content-box-color: #a5a5a5;
      --admin-menu-color: #ffb7b7;
      --manager-menu-color: #fff89a;
      --regular-menu-color: #8fffff;
  }    

  html {
      font-size: 62.5%;
      overflow-x: hidden;
  }

  body {
      width: 100%;
      height: 100vh;
      background: var(--bg-color);
      display: flex;
      flex-direction: column;
      color: var(--text-color);
  }

  *.hidden {
    display: none;
    min-width: 0px;
    min-height: 0px;
  }
</style>