<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Mirror • Camera</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      height: 100dvh;
      background: #000;
      color: #eee;
      font-family: system-ui, -apple-system, sans-serif;
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }

    /* Main camera area */
    #camera-container {
      flex: 1;
      position: relative;
      background: #0a0a0a;
      overflow: hidden;
    }

    #video {
      width: 100%;
      height: 100%;
      object-fit: cover;
      filter: blur(18px) brightness(0.45) contrast(0.9);
      transform: scale(1.08);
    }

    /* Overlay message */
    #overlay {
      position: absolute;
      inset: 0;
      background: rgba(0,0,0,0.78);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      padding: 30px;
      backdrop-filter: blur(4px);
    }

    .logo {
      font-size: 4.8rem;
      font-weight: 700;
      letter-spacing: -2px;
      background: linear-gradient(90deg, #c0c0c0, #ffffff, #c0c0c0);
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
      margin-bottom: 0.4rem;
      text-shadow: 0 0 40px rgba(220,220,220,0.25);
    }

    .status {
      font-size: 1.35rem;
      font-weight: 400;
      opacity: 0.92;
      line-height: 1.4;
      max-width: 320px;
      margin: 12px 0 28px;
    }

    .pulse-dot {
      display: inline-block;
      width: 10px;
      height: 10px;
      background: #ff3366;
      border-radius: 50%;
      margin-left: 6px;
      animation: pulse 1.8s infinite;
      vertical-align: middle;
    }

    @keyframes pulse {
      0%, 100% { transform: scale(1); opacity: 0.4; }
      50%      { transform: scale(1.9); opacity: 1; }
    }

    .hint {
      font-size: 0.96rem;
      opacity: 0.6;
      margin-top: 40px;
    }

    /* Bottom bar (fake controls) */
    #bottom-bar {
      height: 90px;
      background: linear-gradient(to top, #000, transparent);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 60px;
      font-size: 2.1rem;
      color: #555;
    }

    .btn-fake {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      border: 3px solid #444;
      background: rgba(30,30,30,0.6);
      backdrop-filter: blur(6px);
    }

    .btn-fake.center {
      border-color: #777;
      background: rgba(80,80,80,0.4);
    }
  </style>
</head>
<body>

  <div id="camera-container">
    <video id="video" autoplay playsinline muted></video>

    <div id="overlay">
      <div class="logo">Mirror</div>
      <div class="status">
        Mirror is currently being used by <strong>thousands</strong> of people.<br>
        Please try again in a moment<span class="pulse-dot"></span>
      </div>

      <div class="hint">
        Our servers are working hard to give everyone the best mirror experience possible.
      </div>
    </div>
  </div>

  <div id="bottom-bar">
    <div class="btn-fake"></div>
    <div class="btn-fake center"></div>
    <div class="btn-fake"></div>
  </div>

  <script>
    const video = document.getElementById('video');

    // Try to get camera (will most likely work)
    async function startCamera() {
      try {
        const stream = await navigator.mediaDevices.getUserMedia({
          video: {
            facingMode: "user",         // front camera
            width: { ideal: 1280 },
            height: { ideal: 1280 }
          }
        });
        video.srcObject = stream;
      } catch (err) {
        console.warn("Camera access denied or unavailable", err);
        // Still show blurred black-ish background
        video.style.display = 'none';
        document.body.style.background = 'radial-gradient(circle at 50% 30%, #111, #000)';
      }
    }

    startCamera();

    // Optional: fake loading delay then show "busy" (if you want to test both states)
    // setTimeout(() => {
    //   document.getElementById('overlay').style.display = 'flex';
    // }, 6000);
  </script>
</body>
</html>
