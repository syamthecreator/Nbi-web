/**
 * NBI - World-Class Sign Up & OTP Verification Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  const signupForm = document.getElementById('signupForm');
  const step1 = document.getElementById('step1');
  const step2 = document.getElementById('step2');
  const btnSendOtp = document.getElementById('btnSendOtp');
  const btnBackToStep1 = document.getElementById('btnBackToStep1');
  const sentTarget = document.getElementById('sentTarget');
  const otpDigits = document.querySelectorAll('.otp-digit');
  const btnResend = document.getElementById('btnResend');
  const resendCountdown = document.getElementById('resendCountdown');
  const btnVerifyOtp = document.getElementById('btnVerifyOtp');

  let countdownInterval = null;

  // Handle Initial Form Submission (Send OTP)
  if (signupForm) {
    signupForm.addEventListener('submit', (e) => {
      e.preventDefault();

      if (step1.classList.contains('active')) {
        const fullname = document.getElementById('fullname')?.value.trim();
        const email = document.getElementById('email')?.value.trim();
        const phone = document.getElementById('phone')?.value.trim();
        const termsChecked = document.getElementById('termsCheck')?.checked;

        if (!fullname || !email || !phone) {
          alert('Please fill in Name, Email, and Contact fields.');
          return;
        }

        if (!termsChecked) {
          alert('Please accept the Terms of Service to proceed.');
          return;
        }

        // Show Loading State on Button
        btnSendOtp.classList.add('loading');
        btnSendOtp.disabled = true;

        setTimeout(() => {
          btnSendOtp.classList.remove('loading');
          btnSendOtp.disabled = false;

          // Transition to OTP Step
          step1.classList.remove('active');
          step2.classList.add('active');

          if (sentTarget) {
            sentTarget.textContent = `+91 ${phone}`;
          }

          // Focus First OTP Box
          if (otpDigits.length > 0) {
            otpDigits[0].focus();
          }

          // Start Resend Timer
          startResendTimer();

        }, 800);
      }
    });
  }

  const formHeader = document.getElementById('formHeader');
  const formDivider = document.getElementById('formDivider');

  // Function to return to Step 1 (Email & Phone page)
  function goToStep1() {
    if (step3) step3.classList.remove('active');
    step2.classList.remove('active');
    step1.classList.add('active');
    if (formHeader) formHeader.style.display = 'block';
    if (formDivider) formDivider.style.display = 'flex';
    clearInterval(countdownInterval);
    document.getElementById('email')?.focus();
  }

  // Handle Back Buttons
  if (btnBackToStep1) {
    btnBackToStep1.addEventListener('click', goToStep1);
  }

  const btnChangeDetails = document.getElementById('btnChangeDetails');
  if (btnChangeDetails) {
    btnChangeDetails.addEventListener('click', goToStep1);
  }

  // OTP Inputs Auto-advance & Navigation
  otpDigits.forEach((input, index) => {
    input.addEventListener('input', (e) => {
      const val = e.target.value;
      if (val.length > 1) {
        const digits = val.replace(/\D/g, '').split('');
        digits.forEach((d, i) => {
          if (otpDigits[index + i]) {
            otpDigits[index + i].value = d;
          }
        });
        const targetFocus = Math.min(index + digits.length, otpDigits.length - 1);
        otpDigits[targetFocus].focus();
      } else if (val && index < otpDigits.length - 1) {
        otpDigits[index + 1].focus();
      }
    });

    input.addEventListener('keydown', (e) => {
      if (e.key === 'Backspace' && !input.value && index > 0) {
        otpDigits[index - 1].focus();
      }
    });

    input.addEventListener('paste', (e) => {
      e.preventDefault();
      const pastedData = (e.clipboardData || window.clipboardData).getData('text').trim().replace(/\D/g, '');
      if (pastedData) {
        pastedData.split('').forEach((char, i) => {
          if (otpDigits[i]) {
            otpDigits[i].value = char;
          }
        });
        const lastIdx = Math.min(pastedData.length - 1, otpDigits.length - 1);
        otpDigits[lastIdx].focus();
      }
    });
  });

  // Start Resend Timer
  function startResendTimer() {
    let secondsLeft = 30;
    btnResend.disabled = true;
    resendCountdown.textContent = secondsLeft;

    clearInterval(countdownInterval);
    countdownInterval = setInterval(() => {
      secondsLeft--;
      if (resendCountdown) resendCountdown.textContent = secondsLeft;

      if (secondsLeft <= 0) {
        clearInterval(countdownInterval);
        btnResend.disabled = false;
        btnResend.innerHTML = 'Resend OTP';
      }
    }, 1000);
  }

  // Resend OTP Click
  if (btnResend) {
    btnResend.addEventListener('click', () => {
      btnResend.innerHTML = 'Sending...';
      setTimeout(() => {
        btnResend.innerHTML = 'Resend OTP (<span id="resendCountdown">30</span>s)';
        startResendTimer();
        alert('A new OTP has been sent to your mobile & email.');
      }, 600);
    });
  }

  // Verify OTP Action -> Transition to Step 3 Success Screen
  const step3 = document.getElementById('step3');
  const successName = document.getElementById('successName');
  const successEmail = document.getElementById('successEmail');
  const successPhone = document.getElementById('successPhone');
  const redirectTimer = document.getElementById('redirectTimer');
  const redirectBar = document.getElementById('redirectBar');

  if (btnVerifyOtp) {
    btnVerifyOtp.addEventListener('click', () => {
      let otpCode = '';
      otpDigits.forEach(input => otpCode += input.value);

      if (otpCode.length < 4) {
        alert('Please enter a valid 4-digit OTP code.');
        return;
      }

      // Show Loading State on Verify Button
      btnVerifyOtp.innerHTML = 'Verifying...';
      btnVerifyOtp.disabled = true;

      setTimeout(() => {
        const fullname = document.getElementById('fullname')?.value.trim() || 'Rahul Sharma';
        const email = document.getElementById('email')?.value.trim() || 'email@gmail.com';
        const phone = document.getElementById('phone')?.value.trim() || '8787878888';

        localStorage.setItem('nbi_user_name', fullname);
        localStorage.setItem('nbi_user_email', email);
        localStorage.setItem('nbi_user_phone', phone);
        localStorage.setItem('nbi_user_verified', 'true');

        if (successName) successName.textContent = fullname;
        if (successEmail) successEmail.textContent = email;
        if (successPhone) successPhone.textContent = `+91 ${phone}`;

        // Determine destination based on user role
        const userRole = localStorage.getItem('nbi_user_role') || 'institution';
        const targetUrl = (userRole === 'institution') ? 'create-workspace.html' : 'select-institution.html';
        const btnGoHome = document.getElementById('btnGoHome');

        if (btnGoHome) {
          btnGoHome.setAttribute('href', targetUrl);
          const btnText = btnGoHome.querySelector('.btn-text');
          if (btnText) {
            btnText.textContent = (userRole === 'institution') ? 'Continue to Create Workspace' : 'Continue to Select Institution';
          }
        }

        // Hide Sign Up Header & Divider for clean Success UI
        if (formHeader) formHeader.style.display = 'none';
        if (formDivider) formDivider.style.display = 'none';

        // Hide Step 2 & Show Step 3
        step2.classList.remove('active');
        if (step3) step3.classList.add('active');

        // Start Auto Redirect Countdown (5s)
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
            window.location.href = targetUrl;
          }
        }, 1000);

      }, 600);
    });
  }
});
