/**
 * NBI - Notice Board India
 * Application Core Entry Point & Splash Screen Router
 */

document.addEventListener('DOMContentLoaded', () => {
  console.log('NBI Application initialized.');

  const splashContainer = document.getElementById('splash-screen');
  if (splashContainer) {
    let redirected = false;

    const navigateToNext = () => {
      if (!redirected) {
        redirected = true;
        window.location.href = 'pages/select-role.html';
      }
    };

    // Auto navigate to select-role.html after 5 seconds
    const timer = setTimeout(navigateToNext, 5000);

    // Immediate navigate to select-role.html on screen click
    splashContainer.addEventListener('click', () => {
      clearTimeout(timer);
      navigateToNext();
    });

    splashContainer.style.cursor = 'pointer';
  }
});

