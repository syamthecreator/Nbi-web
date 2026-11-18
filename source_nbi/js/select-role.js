/**
 * NBI - Choose Your Role Page Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  const roleCards = document.querySelectorAll('.role-card');
  const btnContinue = document.getElementById('btnContinue');
  let selectedRole = 'institution'; // Institution selected by default

  // Role Card Click Selection
  roleCards.forEach(card => {
    card.addEventListener('click', () => {
      selectRoleCard(card);
    });

    // Keyboard Accessibility (Enter or Space)
    card.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        selectRoleCard(card);
      }
    });
  });

  function selectRoleCard(targetCard) {
    roleCards.forEach(c => {
      c.classList.remove('active');
      c.setAttribute('aria-checked', 'false');
    });

    targetCard.classList.add('active');
    targetCard.setAttribute('aria-checked', 'true');
    selectedRole = targetCard.getAttribute('data-role');

    console.log('Selected Role:', selectedRole);
  }

  // Continue Button Handler
  if (btnContinue) {
    btnContinue.addEventListener('click', () => {
      console.log('Navigating with role:', selectedRole);
      localStorage.setItem('nbi_user_role', selectedRole);

      // Feedback animation on button
      btnContinue.innerHTML = '<span>Saving...</span>';
      btnContinue.style.pointerEvents = 'none';

      setTimeout(() => {
        // Redirect to Sign Up Screen
        window.location.href = 'signup.html';
      }, 600);
    });
  }
});
