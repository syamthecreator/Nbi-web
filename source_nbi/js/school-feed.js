/**
 * NBI - School Feed Dashboard Page Interactivity & Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  // DOM Elements
  const filterChips = document.querySelectorAll('.filter-chip');
  const postCards = document.querySelectorAll('.post-card');
  const feedSearchInput = document.getElementById('feedSearchInput');
  const followBtns = document.querySelectorAll('.btn-follow');
  const likeBtns = document.querySelectorAll('.btn-like');
  const bookmarkBtns = document.querySelectorAll('.btn-bookmark');

  // Dynamically update post author primary school name if user selected a custom school
  try {
    const savedInstStr = sessionStorage.getItem('nbi_selected_institution');
    const schoolConfigsStr = sessionStorage.getItem('nbi_school_configs');

    let userSchoolName = null;

    if (savedInstStr) {
      const inst = JSON.parse(savedInstStr);
      if (inst && inst.name) userSchoolName = inst.name;
    } else if (schoolConfigsStr) {
      const configs = JSON.parse(schoolConfigsStr);
      const keys = Object.keys(configs);
      if (keys.length > 0 && configs[keys[0]].name) {
        userSchoolName = configs[keys[0]].name;
      }
    }

    if (userSchoolName) {
      const post1SchoolName = document.getElementById('post1SchoolName');
      if (post1SchoolName) post1SchoolName.textContent = userSchoolName;
    }
  } catch (e) {
    console.warn('Could not load user school configuration', e);
  }

  // State Variables
  let selectedCategory = 'all';
  let searchQuery = '';

  const headerSearchInput = document.getElementById('headerSearchInput');
  const searchClearBtn = document.getElementById('searchClearBtn');
  const feedCountBadge = document.getElementById('feedCountBadge');

  // Combined Master Filter Function
  function applyFeedFilters() {
    let visibleCount = 0;

    postCards.forEach(card => {
      const cardCategory = card.getAttribute('data-category');
      const titleText = card.querySelector('.post-title')?.textContent.toLowerCase() || '';
      const bodyText = card.querySelector('.post-text')?.textContent.toLowerCase() || '';
      const schoolNameText = card.querySelector('.school-name')?.textContent.toLowerCase() || '';

      const matchesCategory = (selectedCategory === 'all' || cardCategory === selectedCategory);
      const matchesSearch = !searchQuery || (
        titleText.includes(searchQuery) ||
        bodyText.includes(searchQuery) ||
        schoolNameText.includes(searchQuery)
      );

      if (matchesCategory && matchesSearch) {
        card.style.display = 'block';
        visibleCount++;
      } else {
        card.style.display = 'none';
      }
    });

    if (feedCountBadge) {
      feedCountBadge.textContent = `${visibleCount} ${visibleCount === 1 ? 'Update' : 'Updates'}`;
    }
  }

  // 1. Category Filter Chip Functionality
  filterChips.forEach(chip => {
    chip.addEventListener('click', () => {
      filterChips.forEach(c => c.classList.remove('active'));
      chip.classList.add('active');

      selectedCategory = chip.getAttribute('data-filter') || 'all';
      applyFeedFilters();
    });
  });

  // 2. Real-Time Search Bar Filter for Header & Right Sidebar Inputs
  const allSearchInputs = document.querySelectorAll('.header-search-input, .feed-search-input');
  
  allSearchInputs.forEach(input => {
    input.addEventListener('input', (e) => {
      searchQuery = e.target.value.toLowerCase().trim();

      // Sync all search inputs across header and sidebar
      allSearchInputs.forEach(otherInput => {
        if (otherInput !== input) {
          otherInput.value = e.target.value;
        }
      });

      if (searchClearBtn) {
        searchClearBtn.style.display = searchQuery.length > 0 ? 'flex' : 'none';
      }

      applyFeedFilters();
    });
  });

  if (searchClearBtn) {
    searchClearBtn.addEventListener('click', () => {
      searchQuery = '';
      allSearchInputs.forEach(input => input.value = '');
      searchClearBtn.style.display = 'none';
      applyFeedFilters();
    });
  }

  // 3. Instagram-Style Interactive Following Pill Buttons
  const followingPillBtns = document.querySelectorAll('.following-pill-tag, .btn-follow');
  followingPillBtns.forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.stopPropagation();
      const textSpan = btn.querySelector('.following-text');

      if (btn.classList.contains('state-following')) {
        btn.classList.remove('state-following');
        btn.classList.add('state-follow');
        if (textSpan) textSpan.textContent = 'Follow';
        showFeedToast('Unfollowed school updates');
      } else {
        btn.classList.remove('state-follow');
        btn.classList.add('state-following');
        if (textSpan) textSpan.textContent = 'Following';
        showFeedToast('Subscribed to school updates!');
      }
    });
  });

  // Toast Alert Trigger Helper
  const feedToastAlert = document.getElementById('feedToastAlert');
  const feedToastMsg = document.getElementById('feedToastMsg');

  function showFeedToast(message) {
    if (feedToastAlert && feedToastMsg) {
      feedToastMsg.textContent = message;
      feedToastAlert.classList.add('show');
      setTimeout(() => {
        feedToastAlert.classList.remove('show');
      }, 3000);
    }
  }

  // 4. Interactive Like Buttons with Color Change & Count Toggle
  likeBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const countEl = btn.querySelector('.action-count');
      let currentCount = parseInt(countEl?.textContent || '0', 10);

      if (btn.classList.contains('liked')) {
        btn.classList.remove('liked');
        if (countEl) countEl.textContent = (currentCount - 1).toString();
      } else {
        btn.classList.add('liked');
        if (countEl) countEl.textContent = (currentCount + 1).toString();
      }
    });
  });

  // 5. Interactive Share Buttons with Web Share API & Clipboard Copy Fallback
  const shareBtns = document.querySelectorAll('.btn-share');
  shareBtns.forEach(btn => {
    btn.addEventListener('click', async () => {
      const postCard = btn.closest('.post-card');
      const postTitle = postCard?.querySelector('.post-title')?.textContent.trim() || 'School Feed Announcement';
      const postText = postCard?.querySelector('.post-text')?.textContent.trim() || '';

      const shareData = {
        title: postTitle,
        text: `${postTitle}\n${postText}`,
        url: window.location.href
      };

      try {
        if (navigator.share && navigator.canShare && navigator.canShare(shareData)) {
          await navigator.share(shareData);
        } else {
          await navigator.clipboard.writeText(`${postTitle}\n\nRead more on Notice Board India:\n${window.location.href}`);
          showFeedToast('🔗 Post link copied to clipboard!');
        }
      } catch (err) {
        if (err.name !== 'AbortError') {
          try {
            await navigator.clipboard.writeText(`${postTitle}\n\nRead more on Notice Board India:\n${window.location.href}`);
            showFeedToast('🔗 Post link copied to clipboard!');
          } catch (e) {
            showFeedToast('🔗 Post link copied!');
          }
        }
      }
    });
  });

  // 6. Interactive Bookmark Buttons
  bookmarkBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      btn.classList.toggle('bookmarked');
    });
  });

  // 7. 3-Dot Options Dropdown & Pin Post Feature
  const moreOptionsBtns = document.querySelectorAll('.btn-more-options');
  const postsStreamContainer = document.querySelector('.posts-stream');

  // Close all dropdowns
  function closeAllPostDropdowns() {
    document.querySelectorAll('.post-options-dropdown').forEach(dropdown => {
      dropdown.classList.remove('show');
    });
    moreOptionsBtns.forEach(btn => btn.classList.remove('active'));
  }

  // Toggle dropdown on 3 dots click
  moreOptionsBtns.forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.stopPropagation();
      const dropdown = btn.nextElementSibling;
      const isOpen = dropdown?.classList.contains('show');

      closeAllPostDropdowns();

      if (!isOpen && dropdown) {
        dropdown.classList.add('show');
        btn.classList.add('active');
      }
    });
  });

  // Close dropdown when clicking anywhere outside
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.post-header-actions')) {
      closeAllPostDropdowns();
    }
  });

  // Handle Dropdown Actions (Pin to Top, Copy Link, Mute, Report)
  document.querySelectorAll('.post-options-dropdown').forEach(dropdown => {
    const postCard = dropdown.closest('.post-card');

    // Action 1: Pin / Unpin Post
    const pinBtn = dropdown.querySelector('.btn-pin-post');
    if (pinBtn) {
      pinBtn.addEventListener('click', () => {
        closeAllPostDropdowns();
        const badgeWrapper = postCard.querySelector('.badge-wrapper');
        const pinTextEl = pinBtn.querySelector('.dropdown-text');
        const pinIconEl = pinBtn.querySelector('.dropdown-icon');

        const isPinned = postCard.classList.contains('pinned-post');

        if (isPinned) {
          postCard.classList.remove('pinned-post');
          badgeWrapper?.querySelector('.badge-pinned')?.remove();
          if (pinTextEl) pinTextEl.textContent = 'Pin to Top of Feed';
          if (pinIconEl) pinIconEl.textContent = '📌';
          showFeedToast('📍 Announcement unpinned.');
        } else {
          postCard.classList.add('pinned-post');

          // Add Pinned Badge if not already present
          if (badgeWrapper && !badgeWrapper.querySelector('.badge-pinned')) {
            const pinnedBadge = document.createElement('span');
            pinnedBadge.className = 'badge badge-pinned';
            pinnedBadge.style.marginRight = '6px';
            pinnedBadge.textContent = '📌 PINNED ANNOUNCEMENT';
            badgeWrapper.prepend(pinnedBadge);
          }

          // Move pinned post to top of posts stream
          if (postsStreamContainer) {
            postsStreamContainer.prepend(postCard);
          }

          if (pinTextEl) pinTextEl.textContent = 'Unpin from Top';
          if (pinIconEl) pinIconEl.textContent = '📍';
          showFeedToast('📌 Announcement pinned to the top of your feed!');
        }
      });
    }

    // Action 2: Copy Direct Link
    const copyLinkBtn = dropdown.querySelector('.btn-copy-link');
    if (copyLinkBtn) {
      copyLinkBtn.addEventListener('click', async () => {
        closeAllPostDropdowns();
        const postTitle = postCard?.querySelector('.post-title')?.textContent.trim() || 'Notice Board India Post';
        try {
          await navigator.clipboard.writeText(`${postTitle}\n${window.location.href}`);
          showFeedToast('🔗 Direct notice link copied to clipboard!');
        } catch (e) {
          showFeedToast('🔗 Direct notice link copied!');
        }
      });
    }

    // Action 3: Mute / Unmute School Alerts
    const muteBtn = dropdown.querySelector('.btn-mute-school');
    if (muteBtn) {
      muteBtn.addEventListener('click', () => {
        closeAllPostDropdowns();
        const isMuted = muteBtn.classList.toggle('muted');
        const muteText = muteBtn.querySelector('.dropdown-text');
        const schoolName = postCard?.querySelector('.school-name')?.textContent || 'this school';

        if (isMuted) {
          if (muteText) muteText.textContent = 'Unmute School Alerts';
          showFeedToast(`🔕 Alerts muted for ${schoolName}.`);
        } else {
          if (muteText) muteText.textContent = 'Mute School Alerts';
          showFeedToast(`🔔 Alerts unmuted for ${schoolName}.`);
        }
      });
    }

    // Action 4: Report Announcement
    const reportBtn = dropdown.querySelector('.btn-report-post');
    if (reportBtn) {
      reportBtn.addEventListener('click', () => {
        closeAllPostDropdowns();
        showFeedToast('🚩 Announcement reported to school administrators for review.');
      });
    }
  });

  // 6. Sponsored Store Ad Auto Slideshow
  const adWidget = document.getElementById('adSlideshowWidget');
  const adTrack = document.getElementById('adSlideshowTrack');
  const adDots = document.querySelectorAll('#adSlideshowDots .dot');
  const adPrevBtn = document.getElementById('adSlidePrev');
  const adNextBtn = document.getElementById('adSlideNext');

  if (adWidget && adTrack) {
    let currentSlide = 0;
    const slides = adTrack.querySelectorAll('.ad-slide');
    const totalSlides = slides.length || 3;
    let slideInterval = null;
    const slideDuration = 5000; // 5 seconds per slide

    function goToSlide(index) {
      currentSlide = (index + totalSlides) % totalSlides;
      adTrack.style.transform = `translateX(-${currentSlide * (100 / totalSlides)}%)`;

      // Update dots
      adDots.forEach((dot, idx) => {
        dot.classList.toggle('active', idx === currentSlide);
      });

      // Manage video playback for all video slides
      slides.forEach((slideEl, idx) => {
        const videoEl = slideEl.querySelector('video');
        if (videoEl) {
          if (idx === currentSlide) {
            videoEl.play().catch(() => {});
          } else {
            videoEl.pause();
          }
        }
      });
    }

    function startAutoSlide() {
      stopAutoSlide();
      slideInterval = setInterval(() => {
        goToSlide(currentSlide + 1);
      }, slideDuration);
    }

    function stopAutoSlide() {
      if (slideInterval) {
        clearInterval(slideInterval);
        slideInterval = null;
      }
    }

    // Dot click listeners
    adDots.forEach(dot => {
      dot.addEventListener('click', () => {
        const slideIndex = parseInt(dot.getAttribute('data-slide') || '0', 10);
        goToSlide(slideIndex);
        startAutoSlide(); // Reset auto timer after manual interaction
      });
    });

    // Prev / Next arrow buttons
    if (adPrevBtn) {
      adPrevBtn.addEventListener('click', () => {
        goToSlide(currentSlide - 1);
        startAutoSlide();
      });
    }

    if (adNextBtn) {
      adNextBtn.addEventListener('click', () => {
        goToSlide(currentSlide + 1);
        startAutoSlide();
      });
    }

    // Pause on hover
    adWidget.addEventListener('mouseenter', stopAutoSlide);
    adWidget.addEventListener('mouseleave', startAutoSlide);

    // Initialize auto slide starting at 1st view (vid2.mp4)
    goToSlide(0);
    startAutoSlide();
  }
});
