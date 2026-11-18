/**
 * NBI - Settings Screen Interactivity & Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  const tabBtns = document.querySelectorAll('.settings-tab-btn');
  const settingCards = document.querySelectorAll('.settings-card');
  const btnSaveSettings = document.getElementById('btnSaveSettings');
  const toastAlert = document.getElementById('toastAlert');
  const currentSchoolName = document.getElementById('settingSchoolName');

  // Load saved institution name if present
  try {
    const savedInstStr = sessionStorage.getItem('nbi_selected_institution');
    if (savedInstStr) {
      const inst = JSON.parse(savedInstStr);
      if (inst && inst.name && currentSchoolName) {
        currentSchoolName.textContent = inst.name;
      }
    }
  } catch (e) {
    console.warn('Could not load institution config', e);
  }

  // Category Tab Switcher
  tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      tabBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const targetTab = btn.getAttribute('data-tab');

      settingCards.forEach(card => {
        const cardSection = card.getAttribute('data-section');
        if (targetTab === 'all' || cardSection === targetTab) {
          card.style.display = 'flex';
        } else {
          card.style.display = 'none';
        }
      });
    });
  });

  // Save Settings Toast Alert
  if (btnSaveSettings) {
    btnSaveSettings.addEventListener('click', () => {
      if (toastAlert) {
        toastAlert.classList.add('show');
        setTimeout(() => {
          toastAlert.classList.remove('show');
        }, 3000);
      }
    });
  }
});
