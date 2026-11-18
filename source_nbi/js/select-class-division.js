/**
 * NBI - Select Class & Division Page Interactivity & Logic (Step 2 of 2)
 */

document.addEventListener('DOMContentLoaded', () => {
  // Default Sample Schools matching screenshot if none saved from Step 1
  const defaultSchools = [
    {
      id: 'inst-st-marys',
      name: 'St. Mary\'s Higher Secondary School',
      crest: '../assets/images/salford-crest.png',
      classes: ['LKG', 'UKG', '1', '2', '3', '4', '5', '6'],
      divisions: ['A', 'B', 'C', 'D', 'E'],
      selectedClass: null,
      selectedDivision: null
    },
    {
      id: 'inst-carmel-girls',
      name: 'Carmel Girls Higher Secondary School',
      crest: '../assets/images/salford-crest.png',
      classes: ['LKG', 'UKG', '1st', '2nd', '3rd', '4th', '5rd', '6th'],
      divisions: ['A', 'B', 'C', 'D', 'E'],
      selectedClass: null,
      selectedDivision: null
    }
  ];

  // DOM Elements
  const classDivisionGrid = document.getElementById('classDivisionGrid');
  const btnNextStep = document.getElementById('btnNextStep');
  const selectionStatus = document.getElementById('selectionStatus');

  // Track configurations per school
  let schoolConfigs = {};

  // Initialize Data
  initSchoolData();

  // Dynamic top offset calculation
  const topHeroWrapper = document.querySelector('.top-hero-wrapper');
  const bottomCardsWrapper = document.querySelector('.bottom-cards-wrapper');

  function adjustTopOffset() {
    if (topHeroWrapper && bottomCardsWrapper) {
      const topHeight = topHeroWrapper.getBoundingClientRect().height;
      bottomCardsWrapper.style.marginTop = `${Math.round(topHeight + 16)}px`;
    }
  }

  window.addEventListener('load', adjustTopOffset);
  window.addEventListener('resize', adjustTopOffset);
  setTimeout(adjustTopOffset, 100);

  // Initialize and Render Cards
  function initSchoolData() {
    let followedList = [];

    try {
      const savedIdsStr = sessionStorage.getItem('nbi_followed_ids');
      const savedInstStr = sessionStorage.getItem('nbi_selected_institution');
      
      if (savedInstStr) {
        const inst = JSON.parse(savedInstStr);
        followedList.push({
          id: inst.id || 'inst-1',
          name: inst.name || 'Kendriya Vidyalaya Pangode',
          crest: '../assets/images/salford-crest.png',
          classes: ['LKG', 'UKG', '1', '2', '3', '4', '5', '6'],
          divisions: ['A', 'B', 'C', 'D', 'E'],
          selectedClass: null,
          selectedDivision: null
        });
      }

      if (savedIdsStr) {
        const parsedIds = JSON.parse(savedIdsStr);
        if (Array.isArray(parsedIds) && parsedIds.length > 1) {
          // Add extra default school for multi-selection demo
          if (followedList.length === 1) {
            followedList.push(defaultSchools[1]);
          }
        }
      }
    } catch (e) {
      console.warn('Could not parse saved session institutions', e);
    }

    // Fallback to default 2 schools if none found
    if (followedList.length === 0) {
      followedList = defaultSchools;
    }

    renderSchoolCards(followedList);
  }

  // Render School Class & Division Cards
  function renderSchoolCards(schools) {
    if (!classDivisionGrid) return;
    classDivisionGrid.innerHTML = '';

    schools.forEach(school => {
      // Store initial state
      schoolConfigs[school.id] = {
        name: school.name,
        selectedClass: school.selectedClass || null,
        selectedDivision: school.selectedDivision || null
      };

      const cardEl = document.createElement('div');
      const isComplete = schoolConfigs[school.id].selectedClass && schoolConfigs[school.id].selectedDivision;
      cardEl.className = `institution-card ${isComplete ? 'is-configured' : ''}`;
      cardEl.setAttribute('data-id', school.id);

      const classList = school.classes || ['LKG', 'UKG', '1', '2', '3', '4', '5', '6'];
      const divisionList = school.divisions || ['A', 'B', 'C', 'D', 'E'];

      cardEl.innerHTML = `
        <!-- Top Row: Crest, School Name & Subtitle -->
        <div class="card-top-row">
          <div class="card-logo-box">
            <img src="${school.crest || '../assets/images/salford-crest.png'}" alt="${escapeHtml(school.name)} Logo" class="school-crest-img">
          </div>
          <div class="card-info-box">
            <h3 class="institution-name">${escapeHtml(school.name)}</h3>
            <p class="school-subtitle">Setup details for students enrolled here.</p>
          </div>
        </div>

        <!-- Section Divider -->
        <div class="card-divider"></div>

        <!-- SELECT CLASS SECTION -->
        <div class="selector-label">SELECT CLASS</div>
        <div class="class-pills-row">
          ${classList.map(cls => `
            <button type="button" class="class-pill-btn ${schoolConfigs[school.id].selectedClass === cls ? 'selected' : ''}" data-school="${school.id}" data-class="${cls}">
              ${escapeHtml(cls)}
            </button>
          `).join('')}
        </div>

        <!-- SELECT DIVISION SECTION -->
        <div class="selector-label">SELECT DIVISION</div>
        <div class="division-circles-row">
          ${divisionList.map(div => `
            <button type="button" class="division-circle-btn ${schoolConfigs[school.id].selectedDivision === div ? 'selected' : ''}" data-school="${school.id}" data-division="${div}">
              ${escapeHtml(div)}
            </button>
          `).join('')}
        </div>
      `;

      // Attach Click Event Handlers for Class Buttons
      const classBtns = cardEl.querySelectorAll('.class-pill-btn');
      classBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
          const schoolId = e.currentTarget.getAttribute('data-school');
          const selectedCls = e.currentTarget.getAttribute('data-class');

          if (schoolConfigs[schoolId].selectedClass === selectedCls) {
            // Deselect if clicking the currently selected class
            schoolConfigs[schoolId].selectedClass = null;
            e.currentTarget.classList.remove('selected');
          } else {
            // Select new class
            classBtns.forEach(b => b.classList.remove('selected'));
            e.currentTarget.classList.add('selected');
            schoolConfigs[schoolId].selectedClass = selectedCls;
          }

          updateCardConfiguredState(cardEl, schoolId);
        });
      });

      // Attach Click Event Handlers for Division Buttons
      const divisionBtns = cardEl.querySelectorAll('.division-circle-btn');
      divisionBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
          const schoolId = e.currentTarget.getAttribute('data-school');
          const selectedDiv = e.currentTarget.getAttribute('data-division');

          if (schoolConfigs[schoolId].selectedDivision === selectedDiv) {
            // Deselect if clicking the currently selected division
            schoolConfigs[schoolId].selectedDivision = null;
            e.currentTarget.classList.remove('selected');
          } else {
            // Select new division
            divisionBtns.forEach(b => b.classList.remove('selected'));
            e.currentTarget.classList.add('selected');
            schoolConfigs[schoolId].selectedDivision = selectedDiv;
          }

          updateCardConfiguredState(cardEl, schoolId);
        });
      });

      classDivisionGrid.appendChild(cardEl);
    });

    updateNextButtonState();
  }

  // Update Card Active / Configured State
  function updateCardConfiguredState(cardEl, schoolId) {
    const config = schoolConfigs[schoolId];
    if (config.selectedClass && config.selectedDivision) {
      cardEl.classList.add('is-configured');
    } else {
      cardEl.classList.remove('is-configured');
    }
    updateNextButtonState();
  }

  // Update Next Button Enabled / Active State & Bottom Action Bar Visibility
  function updateNextButtonState() {
    const schoolIds = Object.keys(schoolConfigs);
    const bottomActionBar = document.querySelector('.bottom-action-bar');
    
    // Check if class AND division are selected for all cards
    const hasAnySelection = schoolIds.some(id => schoolConfigs[id].selectedClass && schoolConfigs[id].selectedDivision);
    const allConfigured = schoolIds.length > 0 && schoolIds.every(id => schoolConfigs[id].selectedClass && schoolConfigs[id].selectedDivision);

    if (hasAnySelection || allConfigured) {
      if (btnNextStep) btnNextStep.disabled = false;
      if (selectionStatus) {
        selectionStatus.textContent = allConfigured
          ? 'Class and division setup complete for all schools'
          : 'Class and division setup in progress';
        selectionStatus.classList.add('active-status');
      }
      if (bottomActionBar) {
        bottomActionBar.classList.add('is-visible');
      }
    } else {
      if (btnNextStep) btnNextStep.disabled = true;
      if (selectionStatus) {
        selectionStatus.textContent = 'Select class and division for your school to continue';
        selectionStatus.classList.remove('active-status');
      }
      if (bottomActionBar) {
        bottomActionBar.classList.remove('is-visible');
      }
    }
  }

  // Next Button Click Event Handler
  if (btnNextStep) {
    btnNextStep.addEventListener('click', () => {
      // Save configuration to sessionStorage
      sessionStorage.setItem('nbi_school_configs', JSON.stringify(schoolConfigs));

      btnNextStep.innerHTML = '<span>Saving...</span>';
      btnNextStep.style.pointerEvents = 'none';

      setTimeout(() => {
        window.location.href = 'school-feed.html';
      }, 500);
    });
  }

  // Utility to prevent XSS
  function escapeHtml(str) {
    return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }
});
