/**
 * NBI - Create Workspace Page Interactivity & Multi-Step Setup Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('createWorkspaceForm');

  // Header & Step Progress Elements
  const workspaceHeaderRow = document.querySelector('.workspace-header-row');
  const workspaceProgressSection = document.querySelector('.workspace-progress-section');
  const workspaceMainTitle = document.querySelector('.workspace-main-title');
  const progressStepLabel = document.querySelector('.progress-step-label');
  const progressBarFill = document.querySelector('.progress-bar-fill');

  // Step Blocks
  const step1Block = document.getElementById('step1Block');
  const step2Block = document.getElementById('step2Block');
  const step3Block = document.getElementById('step3Block');
  const btnGoToStep2 = document.getElementById('btnGoToStep2');
  const btnBackToStep1 = document.getElementById('btnBackToStep1');
  const btnCreateWorkspace = document.getElementById('btnCreateWorkspace');

  // Step 1 Inputs
  const institutionNameInput = document.getElementById('institutionName');
  const workspaceNameInput = document.getElementById('workspaceName');
  const institutionCodeInput = document.getElementById('institutionCode');
  const institutionTypeInput = document.getElementById('institutionType');
  const logoDropzone = document.getElementById('logoDropzone');
  const logoFileInput = document.getElementById('logoFileInput');
  const uploadPlaceholder = document.getElementById('uploadPlaceholder');
  const logoPreviewBox = document.getElementById('logoPreviewBox');
  const logoPreviewImg = document.getElementById('logoPreviewImg');
  const btnRemoveLogo = document.getElementById('btnRemoveLogo');

  // Step 2 Admin Inputs
  const adminFullNameInput = document.getElementById('adminFullName');
  const adminEmailInput = document.getElementById('adminEmail');
  const adminDesignationInput = document.getElementById('adminDesignation');
  const adminMobileInput = document.getElementById('adminMobile');

  // Toast Alerts
  const toastAlert = document.getElementById('workspaceToastAlert');
  const toastMsg = document.getElementById('workspaceToastMsg');

  // Setup Custom Dropdowns (Select2 Style)
  const customDropdowns = document.querySelectorAll('.custom-dropdown-container');
  customDropdowns.forEach(dropdown => {
    const trigger = dropdown.querySelector('.custom-dropdown-trigger');
    const hiddenInput = dropdown.querySelector('input[type="hidden"]');
    const selectedText = dropdown.querySelector('.selected-option-text');
    const options = dropdown.querySelectorAll('.dropdown-option');

    if (trigger && hiddenInput && selectedText) {
      trigger.addEventListener('click', (e) => {
        e.stopPropagation();
        closeAllDropdowns(dropdown);
        dropdown.classList.toggle('open');
      });

      trigger.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          closeAllDropdowns(dropdown);
          dropdown.classList.toggle('open');
        } else if (e.key === 'Escape') {
          dropdown.classList.remove('open');
        }
      });

      options.forEach(opt => {
        opt.addEventListener('click', (e) => {
          e.stopPropagation();
          const val = opt.getAttribute('data-value');
          hiddenInput.value = val;
          selectedText.textContent = val;
          selectedText.classList.remove('placeholder');

          options.forEach(o => o.classList.remove('selected'));
          opt.classList.add('selected');

          dropdown.classList.remove('open');
        });
      });
    }
  });

  function closeAllDropdowns(except = null) {
    customDropdowns.forEach(d => {
      if (d !== except) d.classList.remove('open');
    });
  }

  document.addEventListener('click', () => {
    closeAllDropdowns();
  });

  // Auto-generate Institution Code if empty
  if (institutionCodeInput && !institutionCodeInput.value) {
    const randomCode = 'NBI-SCH-' + Math.floor(1000 + Math.random() * 9000);
    institutionCodeInput.value = randomCode;
  }

  // Auto-populate Workspace Name based on Institution Name input
  if (institutionNameInput && workspaceNameInput) {
    institutionNameInput.addEventListener('input', (e) => {
      const val = e.target.value.trim();
      if (val && !workspaceNameInput.dataset.userEdited) {
        const slug = val.toLowerCase().replace(/[^a-z0-9]/g, '-').replace(/-+/g, '-').replace(/^-|-$/g, '');
        workspaceNameInput.value = slug ? `${slug}-workspace` : '';
      }
    });

    workspaceNameInput.addEventListener('input', () => {
      workspaceNameInput.dataset.userEdited = 'true';
    });
  }

  // School Logo Dropzone Handling (Step 1)
  if (logoDropzone && logoFileInput) {
    logoDropzone.addEventListener('click', (e) => {
      if (e.target !== btnRemoveLogo && !btnRemoveLogo?.contains(e.target)) {
        logoFileInput.click();
      }
    });

    logoFileInput.addEventListener('change', (e) => {
      const file = e.target.files[0];
      if (file) handleLogoFile(file);
    });

    logoDropzone.addEventListener('dragover', (e) => {
      e.preventDefault();
      logoDropzone.classList.add('dragover');
    });

    logoDropzone.addEventListener('dragleave', () => {
      logoDropzone.classList.remove('dragover');
    });

    logoDropzone.addEventListener('drop', (e) => {
      e.preventDefault();
      logoDropzone.classList.remove('dragover');
      if (e.dataTransfer.files && e.dataTransfer.files[0]) {
        handleLogoFile(e.dataTransfer.files[0]);
      }
    });
  }

  function handleLogoFile(file) {
    if (!file.type.startsWith('image/')) {
      showToast('⚠️ Please upload a valid image file (PNG, JPG, SVG)');
      return;
    }

    const reader = new FileReader();
    reader.onload = (e) => {
      if (logoPreviewImg && uploadPlaceholder && logoPreviewBox) {
        logoPreviewImg.src = e.target.result;
        uploadPlaceholder.classList.add('hidden');
        logoPreviewBox.classList.remove('hidden');
      }
    };
    reader.readAsDataURL(file);
  }

  if (btnRemoveLogo) {
    btnRemoveLogo.addEventListener('click', (e) => {
      e.stopPropagation();
      if (logoFileInput) logoFileInput.value = '';
      if (logoPreviewImg) logoPreviewImg.src = '';
      if (logoPreviewBox) logoPreviewBox.classList.add('hidden');
      if (uploadPlaceholder) uploadPlaceholder.classList.remove('hidden');
    });
  }

  // Transition from Step 1 -> Step 2
  if (btnGoToStep2) {
    btnGoToStep2.addEventListener('click', () => {
      const instName = institutionNameInput?.value.trim();
      const instType = institutionTypeInput?.value;
      const wsName = workspaceNameInput?.value.trim();
      const instCode = institutionCodeInput?.value.trim();

      if (!instName || !instType || !wsName || !instCode) {
        showToast('⚠️ Please fill in all required fields marked with *');
        return;
      }

      // Switch to Step 2 UI
      step1Block.classList.add('hidden');
      step1Block.classList.remove('active');
      step2Block.classList.remove('hidden');
      step2Block.classList.add('active');

      // Update Header & Progress
      if (workspaceMainTitle) {
        workspaceMainTitle.innerHTML = 'Admin <span class="text-orange">Details</span>';
      }
      if (progressStepLabel) {
        progressStepLabel.textContent = 'Step 2/2';
      }
      if (progressBarFill) {
        progressBarFill.style.width = '100%';
      }

      // Pre-fill Admin inputs from Sign-Up data if empty
      const savedName = localStorage.getItem('nbi_user_name');
      const savedEmail = localStorage.getItem('nbi_user_email');
      const savedPhone = localStorage.getItem('nbi_user_phone');

      if (adminFullNameInput && !adminFullNameInput.value && savedName) {
        adminFullNameInput.value = savedName;
      }
      if (adminEmailInput && !adminEmailInput.value && savedEmail) {
        adminEmailInput.value = savedEmail;
      }
      if (adminMobileInput && !adminMobileInput.value && savedPhone) {
        adminMobileInput.value = savedPhone;
      }

      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // Transition from Step 2 -> Step 1
  if (btnBackToStep1) {
    btnBackToStep1.addEventListener('click', () => {
      step2Block.classList.add('hidden');
      step2Block.classList.remove('active');
      step1Block.classList.remove('hidden');
      step1Block.classList.add('active');

      if (workspaceMainTitle) {
        workspaceMainTitle.innerHTML = 'Create <span class="text-orange">Workspace</span>';
      }
      if (progressStepLabel) {
        progressStepLabel.textContent = 'Step 1/2';
      }
      if (progressBarFill) {
        progressBarFill.style.width = '50%';
      }

      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // Final Form Submission (Step 2 -> Step 3 Success Screen)
  if (form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault();

      const instName = institutionNameInput?.value.trim();
      const instType = institutionTypeInput?.value;
      const wsName = workspaceNameInput?.value.trim();
      const instCode = institutionCodeInput?.value.trim();

      const adminName = adminFullNameInput?.value.trim();
      const adminEmail = adminEmailInput?.value.trim();
      const adminDesignation = adminDesignationInput?.value;
      const adminMobile = adminMobileInput?.value.trim();

      if (!adminName || !adminEmail || !adminDesignation || !adminMobile) {
        showToast('⚠️ Please fill in all required Admin details marked with *');
        return;
      }

      // Save Full Config to Session & Local Storage
      const workspaceConfig = {
        institutionName: instName,
        institutionType: instType,
        workspaceName: wsName,
        institutionCode: instCode,
        logo: logoPreviewImg?.src || null,
        adminName: adminName,
        adminEmail: adminEmail,
        adminDesignation: adminDesignation,
        adminMobile: adminMobile,
        createdDate: new Date().toISOString()
      };

      sessionStorage.setItem('nbi_selected_institution', JSON.stringify({
        id: 'user-inst-1',
        name: instName,
        type: instType,
        code: instCode
      }));
      sessionStorage.setItem('nbi_workspace_config', JSON.stringify(workspaceConfig));

      // Hide Header branding & Progress section for clean Success UI
      if (workspaceHeaderRow) workspaceHeaderRow.style.display = 'none';
      if (workspaceProgressSection) workspaceProgressSection.style.display = 'none';

      // Hide Step 2 & Show Step 3 Success Screen
      step2Block.classList.add('hidden');
      step2Block.classList.remove('active');

      if (step3Block) {
        step3Block.classList.remove('hidden');
        step3Block.classList.add('active');
      }

      // Populate Step 3 Summary Card Elements
      const summaryInstName = document.getElementById('summaryInstName');
      const summaryInstType = document.getElementById('summaryInstType');
      const summaryWsName = document.getElementById('summaryWsName');
      const summaryInstCode = document.getElementById('summaryInstCode');
      const summaryAdminName = document.getElementById('summaryAdminName');
      const summaryAdminRole = document.getElementById('summaryAdminRole');
      const summaryLogoPreview = document.getElementById('summaryLogoPreview');

      if (summaryInstName) summaryInstName.textContent = instName;
      if (summaryInstType) summaryInstType.textContent = instType;
      if (summaryWsName) summaryWsName.textContent = `nbi.in/${wsName}`;
      if (summaryInstCode) summaryInstCode.textContent = instCode;
      if (summaryAdminName) summaryAdminName.textContent = adminName;
      if (summaryAdminRole) summaryAdminRole.textContent = adminDesignation;

      if (summaryLogoPreview && logoPreviewImg?.src) {
        summaryLogoPreview.innerHTML = `<img src="${logoPreviewImg.src}" alt="Logo">`;
      }

      window.scrollTo({ top: 0, behavior: 'smooth' });

      // Start 5-second Auto-Redirect Timer
      const redirectTimer = document.getElementById('redirectTimer');
      const redirectBar = document.getElementById('redirectBar');

      let seconds = 5;
      if (redirectBar) {
        redirectBar.style.transition = 'width 5s linear';
        setTimeout(() => { redirectBar.style.width = '100%'; }, 50);
      }

      const timerInterval = setInterval(() => {
        seconds--;
        if (redirectTimer) redirectTimer.textContent = seconds;

        if (seconds <= 0) {
          clearInterval(timerInterval);
          window.location.href = 'school-feed.html';
        }
      }, 1000);
    });
  }

  // Toast Helper
  function showToast(message) {
    if (toastAlert && toastMsg) {
      toastMsg.textContent = message;
      toastAlert.classList.add('show');
      setTimeout(() => {
        toastAlert.classList.remove('show');
      }, 4000);
    }
  }
});
