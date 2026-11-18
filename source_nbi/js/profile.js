/**
 * NBI - User Profile Screen Interactivity & Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  const profileTabBtns = document.querySelectorAll('.profile-tab-btn');
  const profileTabContents = document.querySelectorAll('.profile-tab-content');
  const btnDownloadId = document.getElementById('btnDownloadId');
  const btnProfileQr = document.getElementById('btnProfileQr');
  const profileSchoolName = document.getElementById('profileSchoolName');

  // Elements for Custom Role Dropdown
  const customRoleDropdown = document.getElementById('customRoleDropdown');
  const roleDropdownBtn = document.getElementById('roleDropdownBtn');
  const roleDropdownMenu = document.getElementById('roleDropdownMenu');
  const selectedRoleIcon = document.getElementById('selectedRoleIcon');
  const selectedRoleText = document.getElementById('selectedRoleText');
  const roleDropdownItems = document.querySelectorAll('.role-dropdown-item');

  const followingSchoolNameCard = document.getElementById('followingSchoolNameCard');
  const followingClassTag = document.getElementById('followingClassTag');
  const followingDivTag = document.getElementById('followingDivTag');

  // Load Saved Role
  const savedRole = localStorage.getItem('nbi_user_role') || 'Student';
  setCustomRoleUI(savedRole);

  // Toggle Dropdown Menu Open/Close
  if (roleDropdownBtn && customRoleDropdown) {
    roleDropdownBtn.addEventListener('click', (e) => {
      e.stopPropagation();
      const isOpen = customRoleDropdown.classList.toggle('open');
      roleDropdownBtn.setAttribute('aria-expanded', isOpen);
    });
  }

  // Handle Item Click
  roleDropdownItems.forEach(item => {
    item.addEventListener('click', (e) => {
      e.stopPropagation();
      const val = item.getAttribute('data-value');
      setCustomRoleUI(val);
      localStorage.setItem('nbi_user_role', val);
      if (customRoleDropdown) customRoleDropdown.classList.remove('open');
      if (roleDropdownBtn) roleDropdownBtn.setAttribute('aria-expanded', 'false');
    });
  });

  // Close Dropdown On Outside Click
  document.addEventListener('click', (e) => {
    if (customRoleDropdown && !customRoleDropdown.contains(e.target)) {
      customRoleDropdown.classList.remove('open');
      if (roleDropdownBtn) roleDropdownBtn.setAttribute('aria-expanded', 'false');
    }
  });

  function setCustomRoleUI(roleVal) {
    const isParent = roleVal === 'Parent';
    if (selectedRoleIcon) selectedRoleIcon.textContent = isParent ? '👨‍👩‍👧' : '🎓';
    if (selectedRoleText) selectedRoleText.textContent = isParent ? 'Parent' : 'Student';

    roleDropdownItems.forEach(item => {
      const itemVal = item.getAttribute('data-value');
      const isActive = itemVal === roleVal;
      item.classList.toggle('active', isActive);
      item.setAttribute('aria-selected', isActive ? 'true' : 'false');
    });
  }

  // Dynamically load saved user profile data (Name, Email, Contact) & school info
  try {
    const savedName = localStorage.getItem('nbi_user_name');
    const savedEmail = localStorage.getItem('nbi_user_email');
    const savedPhone = localStorage.getItem('nbi_user_phone');

    const profileFullName = document.getElementById('profileFullName');
    const profileEmail = document.getElementById('profileEmail');
    const profilePhone = document.getElementById('profilePhone');
    const profileHeaderNameText = document.getElementById('profileHeaderNameText');

    if (savedName) {
      if (profileFullName) profileFullName.textContent = savedName;
      if (profileHeaderNameText) profileHeaderNameText.textContent = savedName;
    }
    if (savedEmail && profileEmail) profileEmail.textContent = savedEmail;
    if (savedPhone && profilePhone) profilePhone.textContent = `+91 ${savedPhone}`;

    // Load Followed School, Class & Division
    const savedInstStr = sessionStorage.getItem('nbi_selected_institution');
    const savedConfigsStr = sessionStorage.getItem('nbi_class_configs');

    let schoolName = "St. Mary's Higher Secondary School";
    let className = "Class 10";
    let divName = "Division A";

    if (savedInstStr) {
      const inst = JSON.parse(savedInstStr);
      if (inst && inst.name) {
        schoolName = inst.name;
      }
    }

    if (savedConfigsStr) {
      try {
        const configs = JSON.parse(savedConfigsStr);
        const firstKey = Object.keys(configs)[0];
        if (firstKey && configs[firstKey]) {
          const cfg = configs[firstKey];
          if (cfg.selectedClass) className = `Class ${cfg.selectedClass}`;
          if (cfg.selectedDivision) divName = `Division ${cfg.selectedDivision}`;
        }
      } catch (e) {}
    }

    const followingSchoolNameCard1 = document.getElementById('followingSchoolNameCard1');
    const followingClassTag1 = document.getElementById('followingClassTag1');
    const followingDivTag1 = document.getElementById('followingDivTag1');

    if (followingSchoolNameCard1) followingSchoolNameCard1.textContent = schoolName;
    if (followingClassTag1) followingClassTag1.textContent = className;
    if (followingDivTag1) followingDivTag1.textContent = divName;

  } catch (e) {
    console.warn('Could not load institution or user profile info', e);
  }

  // Download Digital Student ID Card simulation
  if (btnDownloadId) {
    btnDownloadId.addEventListener('click', () => {
      alert('📷 Generating Digital Student ID Card PDF for Rahul Sharma... Download started!');
    });
  }

  // Edit Profile Modal Elements & Logic
  const btnOpenEditModal = document.getElementById('btnOpenEditModal');
  const editProfileModal = document.getElementById('editProfileModal');
  const btnCloseEditModal = document.getElementById('btnCloseEditModal');
  const btnCancelEditModal = document.getElementById('btnCancelEditModal');
  const editProfileForm = document.getElementById('editProfileForm');

  const editFullName = document.getElementById('editFullName');
  const editEmail = document.getElementById('editEmail');
  const editPhone = document.getElementById('editPhone');
  const toastAlert = document.getElementById('toastAlert');

  function openEditModal() {
    const currentName = localStorage.getItem('nbi_user_name') || document.getElementById('profileFullName')?.textContent.trim() || 'Rahul Sharma';
    const currentEmail = localStorage.getItem('nbi_user_email') || document.getElementById('profileEmail')?.textContent.trim() || 'rahul.sharma@nbi-school.edu.in';
    let currentPhone = localStorage.getItem('nbi_user_phone') || document.getElementById('profilePhone')?.textContent.replace('+91', '').trim() || '9876543210';

    if (editFullName) editFullName.value = currentName;
    if (editEmail) editEmail.value = currentEmail;
    if (editPhone) editPhone.value = currentPhone.replace(/\D/g, '').slice(-10);

    if (editProfileModal) editProfileModal.classList.add('open');
  }

  function closeEditModal() {
    if (editProfileModal) editProfileModal.classList.remove('open');
  }

  if (btnOpenEditModal) {
    btnOpenEditModal.addEventListener('click', openEditModal);
  }

  if (btnCloseEditModal) {
    btnCloseEditModal.addEventListener('click', closeEditModal);
  }

  if (btnCancelEditModal) {
    btnCancelEditModal.addEventListener('click', closeEditModal);
  }

  if (editProfileModal) {
    editProfileModal.addEventListener('click', (e) => {
      if (e.target === editProfileModal) {
        closeEditModal();
      }
    });
  }

  if (editProfileForm) {
    editProfileForm.addEventListener('submit', (e) => {
      e.preventDefault();

      const newName = editFullName?.value.trim();
      const newEmail = editEmail?.value.trim();
      const newPhone = editPhone?.value.trim();

      if (!newName || !newEmail || !newPhone) {
        alert('Please fill in all profile fields.');
        return;
      }

      // Save to localStorage
      localStorage.setItem('nbi_user_name', newName);
      localStorage.setItem('nbi_user_email', newEmail);
      localStorage.setItem('nbi_user_phone', newPhone);

      // Update DOM
      const profileFullName = document.getElementById('profileFullName');
      const profileEmail = document.getElementById('profileEmail');
      const profilePhone = document.getElementById('profilePhone');
      const profileHeaderNameText = document.getElementById('profileHeaderNameText');

      if (profileFullName) profileFullName.textContent = newName;
      if (profileHeaderNameText) profileHeaderNameText.textContent = newName;
      if (profileEmail) profileEmail.textContent = newEmail;
      if (profilePhone) profilePhone.textContent = `+91 ${newPhone}`;

      // Close modal
      closeEditModal();

      // Show toast notification
      if (toastAlert) {
        toastAlert.classList.add('show');
        setTimeout(() => {
          toastAlert.classList.remove('show');
        }, 3000);
      }
    });
  }

  // Log Out User Event Listener
  const btnLogoutUser = document.getElementById('btnLogoutUser');
  if (btnLogoutUser) {
    btnLogoutUser.addEventListener('click', () => {
      if (confirm('Are you sure you want to log out of Notice Board India?')) {
        // Clear saved user credentials
        localStorage.removeItem('nbi_user_name');
        localStorage.removeItem('nbi_user_email');
        localStorage.removeItem('nbi_user_phone');
        localStorage.removeItem('nbi_user_verified');
        localStorage.removeItem('nbi_user_role');
        sessionStorage.clear();

        // Redirect to Onboarding / Signup page
        window.location.href = 'signup.html';
      }
    });
  }
});
