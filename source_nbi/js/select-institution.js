/**
 * NBI - Select Institution Page Interactivity & Search Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  // Local Dataset of Educational Institutions
  const institutionsData = [
    {
      id: 'inst-1',
      name: 'Kendriya Vidyalaya Pangode',
      location: 'Pangode, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695006',
      badgeColor: '#1E3A8A'
    },
    {
      id: 'inst-2',
      name: 'Arya Central School',
      location: 'Pattom, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695004',
      badgeColor: '#D97706'
    },
    {
      id: 'inst-3',
      name: 'St. Joseph\'s Higher Secondary School',
      location: 'General Hospital Jn, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695001',
      badgeColor: '#991B1B'
    },
    {
      id: 'inst-4',
      name: 'Loyola School Thiruvananthapuram',
      location: 'Sreekariyam, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695017',
      badgeColor: '#065F46'
    },
    {
      id: 'inst-5',
      name: 'Holy Angels\' Convent HSS',
      location: 'Vanchiyoor, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695035',
      badgeColor: '#7C3AED'
    },
    {
      id: 'inst-6',
      name: 'Saraswathi Vidyalaya',
      location: 'Vattiyoorkavu, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695013',
      badgeColor: '#0284C7'
    },
    {
      id: 'inst-7',
      name: 'Chinmaya Vidyalaya',
      location: 'Attukal, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695009',
      badgeColor: '#EA580C'
    },
    {
      id: 'inst-8',
      name: 'Army Public School Pangode',
      location: 'Cantonment, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695006',
      badgeColor: '#15803D'
    }
  ];

  // DOM Elements
  const institutionGrid = document.getElementById('institutionGrid');
  const searchInput = document.getElementById('institutionSearch');
  const btnClearSearch = document.getElementById('btnClearSearch');
  const resultsMeta = document.getElementById('resultsMeta');
  const emptyState = document.getElementById('emptyState');
  const btnContinue = document.getElementById('btnContinueInstitution');
  const selectionStatus = document.getElementById('selectionStatus');

  // Track Selected Institution IDs in JavaScript State
  let selectedInstitutionIds = new Set();

  // Load Saved Selection from sessionStorage if page is refreshed
  loadSavedState();

  // Initial Render of Cards
  renderCards(institutionsData);

  // Update initial Continue button & bottom action bar visibility state
  updateContinueButtonState();

  // Dynamic offset calculation so cards never get clipped under the fixed top hero section
  const topHeroWrapper = document.querySelector('.top-hero-wrapper');
  const bottomCardsWrapper = document.querySelector('.bottom-cards-wrapper');

  function adjustTopOffset() {
    if (topHeroWrapper && bottomCardsWrapper) {
      const topHeight = topHeroWrapper.getBoundingClientRect().height;
      bottomCardsWrapper.style.marginTop = `${Math.round(topHeight + 16)}px`;
    }
  }

  // Calculate after window and images are fully loaded
  window.addEventListener('load', adjustTopOffset);
  window.addEventListener('resize', adjustTopOffset);
  setTimeout(adjustTopOffset, 100);

  // Search Input Listener
  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      const query = e.target.value.toLowerCase().trim();
      
      if (btnClearSearch) {
        btnClearSearch.style.display = query.length > 0 ? 'block' : 'none';
      }

      filterAndRender(query);
    });
  }

  // Clear Search Button
  if (btnClearSearch) {
    btnClearSearch.addEventListener('click', () => {
      searchInput.value = '';
      btnClearSearch.style.display = 'none';
      filterAndRender('');
      searchInput.focus();
    });
  }

  // Filter Logic
  function filterAndRender(query) {
    if (!query) {
      renderCards(institutionsData);
      emptyState.style.display = 'none';
      return;
    }

    const filtered = institutionsData.filter(inst => {
      return inst.name.toLowerCase().includes(query) ||
             inst.location.toLowerCase().includes(query) ||
             inst.city.toLowerCase().includes(query) ||
             inst.pincode.includes(query);
    });

    if (filtered.length === 0) {
      institutionGrid.style.display = 'none';
      emptyState.style.display = 'block';
      resultsMeta.textContent = 'No matching institutions';
    } else {
      institutionGrid.style.display = 'grid';
      emptyState.style.display = 'none';
      renderCards(filtered);
    }
  }

  // Render Institution Cards Grid
  function renderCards(list) {
    resultsMeta.textContent = `Showing ${list.length} available institution${list.length > 1 ? 's' : ''}`;
    institutionGrid.innerHTML = '';

    list.forEach(inst => {
      const isFollowing = selectedInstitutionIds.has(inst.id);

      const cardEl = document.createElement('div');
      cardEl.className = `institution-card ${isFollowing ? 'is-following' : ''}`;
      cardEl.setAttribute('data-id', inst.id);

      cardEl.innerHTML = `
        <div class="card-top-row">
          <div class="card-logo-box">
            <img src="../assets/images/salford-crest.png" alt="School Crest Logo" class="school-crest-img">
          </div>
          <div class="card-info-box">
            <h3 class="institution-name">${escapeHtml(inst.name)}</h3>
            <p class="institution-location">
              <svg class="loc-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                <circle cx="12" cy="10" r="3"></circle>
              </svg>
              ${escapeHtml(inst.location)}
            </p>
          </div>
        </div>

        <button type="button" class="btn-follow ${isFollowing ? 'state-following' : 'state-follow'}" data-id="${inst.id}">
          ${isFollowing ? `
            <span>Following</span>
            <svg class="check-circle-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
              <polyline points="20 6 9 17 4 12"></polyline>
            </svg>
          ` : `
            <span>Follow School</span>
            <span style="font-size: 1.2rem; line-height: 1;">+</span>
          `}
        </button>
      `;

      // Attach Follow Button Click Handler
      const followBtn = cardEl.querySelector('.btn-follow');
      followBtn.addEventListener('click', () => {
        toggleFollow(inst, cardEl, followBtn);
      });

      institutionGrid.appendChild(cardEl);
    });
  }

  // Toggle Follow / Following State
  function toggleFollow(institution, cardEl, btnEl) {
    const instId = institution.id;

    if (selectedInstitutionIds.has(instId)) {
      // Unfollow
      selectedInstitutionIds.delete(instId);
      cardEl.classList.remove('is-following');
      btnEl.className = 'btn-follow state-follow';
      btnEl.innerHTML = `
        <span>Follow School</span>
        <span style="font-size: 1.2rem; line-height: 1;">+</span>
      `;
    } else {
      // Follow
      selectedInstitutionIds.add(instId);
      cardEl.classList.add('is-following');
      btnEl.className = 'btn-follow state-following';
      btnEl.innerHTML = `
        <span>Following</span>
        <svg class="check-circle-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
      `;
    }

    updateContinueButtonState(institution);
  }

  // Update Continue Button Disabled / Active State & Bottom Bar Visibility
  function updateContinueButtonState(lastSelectedInst) {
    const hasSelection = selectedInstitutionIds.size > 0;
    const bottomActionBar = document.querySelector('.bottom-action-bar');

    if (hasSelection) {
      btnContinue.disabled = false;
      selectionStatus.textContent = `${selectedInstitutionIds.size} institution${selectedInstitutionIds.size > 1 ? 's' : ''} followed`;
      selectionStatus.classList.add('active-status');

      // Make bottom action bar visible
      if (bottomActionBar) {
        bottomActionBar.classList.add('is-visible');
      }

      // Save primary selected institution to sessionStorage
      const primaryInst = lastSelectedInst || institutionsData.find(i => selectedInstitutionIds.has(i.id));
      if (primaryInst) {
        sessionStorage.setItem('nbi_selected_institution', JSON.stringify(primaryInst));
        sessionStorage.setItem('nbi_followed_ids', JSON.stringify(Array.from(selectedInstitutionIds)));
      }
    } else {
      btnContinue.disabled = true;
      selectionStatus.textContent = 'Select at least one institution to continue';
      selectionStatus.classList.remove('active-status');

      // Hide bottom action bar when 0 institutions are followed
      if (bottomActionBar) {
        bottomActionBar.classList.remove('is-visible');
      }

      sessionStorage.removeItem('nbi_selected_institution');
      sessionStorage.removeItem('nbi_followed_ids');
    }
  }

  // Load Saved State from sessionStorage
  function loadSavedState() {
    try {
      const savedIds = sessionStorage.getItem('nbi_followed_ids');
      if (savedIds) {
        const parsed = JSON.parse(savedIds);
        if (Array.isArray(parsed)) {
          selectedInstitutionIds = new Set(parsed);
          updateContinueButtonState();
        }
      }
    } catch (e) {
      console.warn('Could not restore saved institution state', e);
    }
  }

  // Continue Button Click Action -> Navigate to select-class-division.html
  if (btnContinue) {
    btnContinue.addEventListener('click', () => {
      if (selectedInstitutionIds.size === 0) return;

      btnContinue.innerHTML = '<span>Saving...</span>';
      btnContinue.style.pointerEvents = 'none';

      setTimeout(() => {
        window.location.href = 'select-class-division.html';
      }, 500);
    });
  }

  // Utility to prevent XSS in text rendering
  function escapeHtml(str) {
    return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }
});
