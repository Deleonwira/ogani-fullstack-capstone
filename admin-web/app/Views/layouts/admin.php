<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title><?= $this->renderSection('title') ?> - Ogani Admin</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
<script id="tailwind-config">
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              "colors": {
                      "tertiary-fixed": "#ffddb8",
                      "secondary-fixed-dim": "#4edea3",
                      "secondary-fixed": "#6ffbbe",
                      "on-tertiary-fixed": "#2a1700",
                      "on-error-container": "#93000a",
                      "secondary": "#006c49",
                      "on-surface-variant": "#3f4a3c",
                      "primary-container": "#4caf50",
                      "on-primary": "#ffffff",
                      "surface-tint": "#006e1c",
                      "primary-fixed": "#94f990",
                      "surface-bright": "#f8f9ff",
                      "error": "#ba1a1a",
                      "on-secondary-fixed-variant": "#005236",
                      "on-primary-container": "#003c0b",
                      "on-primary-fixed": "#002204",
                      "surface-dim": "#cbdbf5",
                      "inverse-primary": "#78dc77",
                      "surface": "#f8f9ff",
                      "on-secondary-container": "#00714d",
                      "surface-container-lowest": "#ffffff",
                      "primary-fixed-dim": "#78dc77",
                      "on-tertiary-fixed-variant": "#653e00",
                      "on-error": "#ffffff",
                      "on-background": "#0b1c30",
                      "on-secondary-fixed": "#002113",
                      "tertiary-fixed-dim": "#ffb95f",
                      "surface-container-low": "#eff4ff",
                      "outline-variant": "#becab9",
                      "surface-variant": "#d3e4fe",
                      "tertiary-container": "#d88a00",
                      "surface-container": "#e5eeff",
                      "outline": "#6f7a6b",
                      "on-secondary": "#ffffff",
                      "on-tertiary-container": "#4a2c00",
                      "secondary-container": "#6cf8bb",
                      "background": "#f8f9ff",
                      "primary": "#006e1c",
                      "surface-container-highest": "#d3e4fe",
                      "on-tertiary": "#ffffff",
                      "surface-container-high": "#dce9ff",
                      "tertiary": "#855300",
                      "on-surface": "#0b1c30",
                      "error-container": "#ffdad6",
                      "on-primary-fixed-variant": "#005313",
                      "inverse-surface": "#213145",
                      "inverse-on-surface": "#eaf1ff"
              },
              "borderRadius": {
                      "DEFAULT": "0.25rem",
                      "lg": "0.5rem",
                      "xl": "0.75rem",
                      "full": "9999px"
              },
              "spacing": {
                      "topbar-height": "72px",
                      "component-gap": "16px",
                      "gutter": "24px",
                      "base": "4px",
                      "sidebar-width": "260px",
                      "container-padding": "32px"
              },
              "fontFamily": {
                      "body-md": ["Plus Jakarta Sans"],
                      "label-sm": ["Plus Jakarta Sans"],
                      "headline-md": ["Plus Jakarta Sans"],
                      "title-lg": ["Plus Jakarta Sans"],
                      "body-lg": ["Plus Jakarta Sans"],
                      "display-lg": ["Plus Jakarta Sans"],
                      "headline-lg": ["Plus Jakarta Sans"],
                      "title-md": ["Plus Jakarta Sans"],
                      "label-md": ["Plus Jakarta Sans"]
              },
              "fontSize": {
                      "body-md": ["14px", { "lineHeight": "20px", "fontWeight": "400" }],
                      "label-sm": ["11px", { "lineHeight": "14px", "fontWeight": "500" }],
                      "headline-md": ["20px", { "lineHeight": "28px", "fontWeight": "600" }],
                      "title-lg": ["18px", { "lineHeight": "24px", "fontWeight": "600" }],
                      "body-lg": ["16px", { "lineHeight": "24px", "fontWeight": "400" }],
                      "display-lg": ["36px", { "lineHeight": "44px", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                      "headline-lg": ["28px", { "lineHeight": "36px", "letterSpacing": "-0.01em", "fontWeight": "700" }],
                      "title-md": ["16px", { "lineHeight": "24px", "fontWeight": "600" }],
                      "label-md": ["12px", { "lineHeight": "16px", "letterSpacing": "0.05em", "fontWeight": "600" }]
              }
            }
          }
        }
    </script>
<style type="text/tailwindcss">
        @layer utilities {
            .table-row-hover {
                @apply hover:bg-surface-container-low transition-colors duration-150 ease-in-out;
            }
            .status-badge-pending {
                @apply bg-tertiary-fixed text-on-tertiary-fixed;
            }
            .status-badge-processing {
                @apply bg-surface-dim text-on-surface;
            }
            .status-badge-shipped {
                @apply bg-secondary-container text-on-secondary-container;
            }
            .status-badge-delivered {
                @apply bg-primary-container text-on-primary-container;
            }
            .status-badge-cancelled {
                @apply bg-error-container text-on-error-container;
            }
        }
    </style>
</head>
<body x-data="{ sidebarOpen: false }" class="bg-background text-on-background min-h-screen font-body-md text-body-md overflow-x-hidden selection:bg-primary-container selection:text-on-primary-container">
<!-- Mobile Sidebar Overlay -->
<div x-show="sidebarOpen" x-transition.opacity @click="sidebarOpen = false" class="fixed inset-0 bg-black/50 z-40 lg:hidden" style="display: none;"></div>
<!-- SideNavBar -->
<nav aria-label="Sidebar Navigation" :class="sidebarOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'" class="fixed left-0 top-0 h-screen w-[260px] bg-surface-container-lowest border-r border-outline-variant shadow-sm z-50 flex flex-col py-gutter px-4 transition-transform duration-300">
<!-- Header -->
<div class="mb-8 px-2 lg:px-4 flex justify-between items-center">
    <div class="flex items-center gap-3">
        <div class="w-10 h-10 flex items-center justify-center text-primary flex-shrink-0">
            <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-full h-full">
                <path d="M 15 35 h 15 v 25 q 0 10 10 10 h 30 q 15 0 15 -15 v -5 q 0 -15 -15 -15 h -25" stroke="currentColor" stroke-width="12" stroke-linecap="round" stroke-linejoin="round"/>
                <circle cx="45" cy="88" r="8" fill="currentColor"/>
                <circle cx="70" cy="88" r="8" fill="currentColor"/>
            </svg>
        </div>
        <div>
            <h1 class="text-title-lg font-title-lg font-bold text-primary tracking-tight">Ogani Admin</h1>
            <p class="text-label-sm font-label-sm text-on-surface-variant">Management</p>
        </div>
    </div>
    <button @click="sidebarOpen = false" class="lg:hidden text-on-surface-variant hover:text-error p-1">
        <span class="material-symbols-outlined">close</span>
    </button>
</div>
<?php
$activeClass = 'relative flex items-center gap-3 px-4 py-3 bg-secondary-container/10 text-primary font-bold rounded-lg overflow-hidden before:absolute before:left-0 before:top-1/2 before:-translate-y-1/2 before:h-[24px] before:w-1 before:bg-primary before:rounded-r-full active:scale-[0.98] transition-transform duration-200';
$inactiveClass = 'flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:text-primary hover:bg-surface-container-low transition-colors rounded-lg';
$activeIconStyle = 'data-weight="fill" style="font-variation-settings: \'FILL\' 1;"';
$active_page = $active_page ?? 'dashboard';
?>
<!-- Navigation Links -->
<ul class="flex-1 space-y-1 overflow-y-auto">
<li>
<a class="<?= $active_page == 'dashboard' ? $activeClass : $inactiveClass ?>" href="/admin/dashboard">
<span class="material-symbols-outlined text-[20px]" data-icon="dashboard" <?= $active_page == 'dashboard' ? $activeIconStyle : '' ?>>dashboard</span>
<span class="font-label-md text-label-md">Dashboard</span>
</a>
</li>
<li>
<a class="<?= $active_page == 'orders' ? $activeClass : $inactiveClass ?>" href="/admin/orders">
<span class="material-symbols-outlined text-[20px]" data-icon="shopping_cart" <?= $active_page == 'orders' ? $activeIconStyle : '' ?>>shopping_cart</span>
<span class="font-label-md text-label-md">Orders</span>
</a>
</li>
<li>
<a class="<?= $active_page == 'products' ? $activeClass : $inactiveClass ?>" href="/admin/products">
<span class="material-symbols-outlined text-[20px]" data-icon="inventory_2" <?= $active_page == 'products' ? $activeIconStyle : '' ?>>inventory_2</span>
<span class="font-label-md text-label-md">Products</span>
</a>
</li>
<li>
<a class="<?= $active_page == 'users' ? $activeClass : $inactiveClass ?>" href="/admin/users">
<span class="material-symbols-outlined text-[20px]" data-icon="group" <?= $active_page == 'users' ? $activeIconStyle : '' ?>>group</span>
<span class="font-label-md text-label-md">Customers</span>
</a>
</li>
<li>
<a class="<?= $active_page == 'categories' ? $activeClass : $inactiveClass ?>" href="/admin/categories">
<span class="material-symbols-outlined text-[20px]" data-icon="category" <?= $active_page == 'categories' ? $activeIconStyle : '' ?>>category</span>
<span class="font-label-md text-label-md">Categories</span>
</a>
</li>
<li>
<a class="<?= $active_page == 'promos' ? $activeClass : $inactiveClass ?>" href="/admin/promos">
<span class="material-symbols-outlined text-[20px]" data-icon="sell" <?= $active_page == 'promos' ? $activeIconStyle : '' ?>>sell</span>
<span class="font-label-md text-label-md">Promotions</span>
</a>
</li>
<li>
<a class="<?= $active_page == 'reviews' ? $activeClass : $inactiveClass ?>" href="/admin/reviews">
<span class="material-symbols-outlined text-[20px]" data-icon="star" <?= $active_page == 'reviews' ? $activeIconStyle : '' ?>>star</span>
<span class="font-label-md text-label-md">Reviews</span>
</a>
</li>
<li>
<a class="<?= $active_page == 'settings' ? $activeClass : $inactiveClass ?>" href="/admin/settings">
<span class="material-symbols-outlined text-[20px]" data-icon="settings" <?= $active_page == 'settings' ? $activeIconStyle : '' ?>>settings</span>
<span class="font-label-md text-label-md">Settings</span>
</a>
</li>
</ul>
<!-- Footer Actions -->
<div class="mt-auto pt-4 border-t border-outline-variant/30">
<a class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:text-error hover:bg-error-container/20 transition-colors rounded-lg" href="/logout">
<span class="material-symbols-outlined text-[20px]" data-icon="logout">logout</span>
<span class="font-label-md text-label-md">Logout</span>
</a>
</div>
</nav>
<!-- Main Content Wrapper -->
<div class="lg:ml-[260px] min-h-screen flex flex-col transition-all duration-300">
<!-- TopNavBar -->
<header class="fixed top-0 right-0 h-topbar-height z-30 flex justify-between items-center w-full lg:w-[calc(100%-260px)] px-4 lg:px-gutter bg-surface-container-lowest border-b border-outline-variant transition-all duration-300">
<div class="flex items-center gap-2 flex-1">
    <button @click="sidebarOpen = true" class="p-2 -ml-2 text-on-surface-variant hover:bg-surface-container-low rounded-lg lg:hidden focus:outline-none">
        <span class="material-symbols-outlined">menu</span>
    </button>
    <!-- Search (Left Aligned) -->
    <div class="flex-1 max-w-md relative hidden sm:block" x-data="globalSearchComponent()">
        <div class="relative group">
        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">search</span>
        <input x-model="query" @input.debounce.300ms="fetchResults" @focus="open = true" @click.outside="open = false" class="w-full h-10 pl-10 pr-4 bg-surface-container-low border border-transparent rounded-full font-body-md text-body-md text-on-surface placeholder:text-outline focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all bg-opacity-50" placeholder="Search orders, customers, or products..." type="text"/>
        
        <!-- Loading spinner -->
        <span x-show="loading" class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-primary animate-spin text-[20px]" style="display: none;">progress_activity</span>
    </div>

    <!-- Dropdown Results -->
    <div x-show="open && (results.length > 0 || query.length > 0)" style="display: none;" class="absolute left-0 mt-2 w-full max-w-md bg-surface-container-lowest border border-outline-variant rounded-xl shadow-lg z-50 overflow-hidden">
        
        <div x-show="results.length > 0" class="max-h-[400px] overflow-y-auto">
            <template x-for="item in results" :key="item.url">
                <a :href="item.url" class="flex items-center gap-3 p-3 border-b border-outline-variant/30 hover:bg-surface-container-low transition-colors text-left w-full">
                    <div class="w-10 h-10 rounded-lg bg-surface-container-high flex items-center justify-center text-primary shrink-0">
                        <span class="material-symbols-outlined" x-text="getIcon(item.type)"></span>
                    </div>
                    <div class="overflow-hidden">
                        <p class="font-title-md text-title-md text-on-surface truncate" x-text="item.title"></p>
                        <p class="font-body-md text-body-md text-on-surface-variant text-sm truncate" x-text="item.subtitle"></p>
                    </div>
                </a>
            </template>
        </div>

        <div x-show="!loading && query.length > 0 && results.length === 0" class="p-4 text-center text-on-surface-variant text-sm">
            No results found for "<span x-text="query"></span>"
        </div>
    </div>
</div>
</div>
<!-- Trailing Actions -->
<div class="flex items-center gap-4 ml-auto">
<div class="relative" x-data="{ open: false }" @click.outside="open = false">
<button @click="open = !open" aria-label="Notifications" class="relative p-2 text-on-surface-variant hover:bg-surface-container-low hover:text-primary rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-primary/20">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
<span class="absolute top-1.5 right-1.5 w-2 h-2 bg-error rounded-full ring-2 ring-surface-container-lowest"></span>
</button>
<div x-show="open" x-transition.opacity.duration.200ms style="display: none;" class="absolute right-0 mt-2 w-80 bg-surface-container-lowest border border-outline-variant rounded-xl shadow-lg z-50 overflow-hidden">
<div class="p-4 border-b border-outline-variant/50">
<h3 class="font-title-md text-on-surface">Notifications</h3>
</div>
<div class="max-h-[300px] overflow-y-auto">
<div class="p-4 border-b border-outline-variant/30 hover:bg-surface-container-low transition-colors cursor-pointer text-sm">
<p class="text-on-surface font-medium">New order received!</p>
<p class="text-on-surface-variant text-xs mt-1">Order #1234 from John Doe</p>
</div>
<div class="p-4 border-b border-outline-variant/30 hover:bg-surface-container-low transition-colors cursor-pointer text-sm">
<p class="text-on-surface font-medium">Product out of stock</p>
<p class="text-on-surface-variant text-xs mt-1">Organic Tomatoes are out of stock.</p>
</div>
</div>
<div class="p-3 text-center">
<a href="/admin/notifications" class="text-primary text-sm font-medium hover:underline">View All Notifications</a>
</div>
</div>
</div>
<div class="h-8 w-px bg-outline-variant mx-1"></div>
<div class="relative" x-data="{ open: false }" @click.outside="open = false">
<button @click="open = !open" class="flex items-center gap-2 p-1 pl-2 pr-4 hover:bg-surface-container-low rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-primary/20 border border-transparent hover:border-outline-variant/50">
<img alt="Admin Avatar" class="w-8 h-8 rounded-full border border-outline-variant/20 shadow-sm" data-alt="A clean, professional headshot avatar of an administrator or professional user. The avatar is set against a solid, subtle organic green background (#006e1c) with white stylized initials. The lighting is soft and flat, perfect for a digital UI profile image. The image embodies trust, efficiency, and a modern corporate identity suitable for an enterprise dashboard." src="https://lh3.googleusercontent.com/aida-public/AB6AXuC-IjZFOb4GkfGOOqthIQzAi82--oIukR6oKBe5XX5D8H4E3DF2J63j5akRvVcX5WxA6kLzyiwypP5Fa3ajLiW6MMbepzK2vzo9h-xylwqCg2lfYrUclHlR8lB73TCELeA7i6GzcDfi8ZfxpE8kry1PmdTBG6ofPEpTv0NdSfOLMPaZBb3TGrItnBf13YwJo-JHj_P1XnK_dU6y5STP3XvwHC85a7mGFfzBXXZh7-E95SmsWZ2p_CFMQD6i5r5JGVHI8GP46EDjKNFo"/>
<span class="font-label-md text-label-md text-on-surface hidden md:block"><?= esc(session()->get('fullName') ?? 'Admin') ?></span>
<span class="material-symbols-outlined text-on-surface-variant text-[18px]">expand_more</span>
</button>
<div x-show="open" x-transition.opacity.duration.200ms style="display: none;" class="absolute right-0 mt-2 w-48 bg-surface-container-lowest border border-outline-variant rounded-xl shadow-lg z-50 overflow-hidden">
<div class="py-2">
<a href="/admin/profile" class="flex items-center gap-3 px-4 py-2 text-sm text-on-surface hover:bg-surface-container-low transition-colors">
<span class="material-symbols-outlined text-[18px]">person</span> My Profile
</a>
<a href="/admin/settings" class="flex items-center gap-3 px-4 py-2 text-sm text-on-surface hover:bg-surface-container-low transition-colors">
<span class="material-symbols-outlined text-[18px]">settings</span> Settings
</a>
<hr class="my-2 border-outline-variant/30">
<a href="/logout" class="flex items-center gap-3 px-4 py-2 text-sm text-error hover:bg-error-container/20 transition-colors">
<span class="material-symbols-outlined text-[18px]">logout</span> Logout
</a>
</div>
</div>
</div>
</div>
</header>
<!-- Page Content Canvas -->
<main class="flex-1 pt-[calc(72px+16px)] lg:pt-[calc(72px+32px)] px-4 lg:px-container-padding pb-8 lg:pb-container-padding max-w-[1600px] mx-auto w-full overflow-x-hidden">
<?= $this->renderSection('content') ?>
</main>
</div>

<!-- Floating Action Bar for Batch Edit Mode -->
<div id="batchEditBar" class="fixed bottom-0 left-[260px] right-0 bg-surface-container-high border-t border-outline-variant/30 shadow-[0_-4px_20px_rgba(0,0,0,0.1)] p-4 flex items-center justify-between z-50 transition-transform duration-300 translate-y-full">
    <div>
        <h3 class="text-title-md font-title-md text-on-surface">Unsaved Changes</h3>
        <p class="text-label-sm font-label-sm text-on-surface-variant" id="batchEditCount">You have 0 pending changes.</p>
    </div>
    <div class="flex items-center gap-3">
        <button onclick="cancelBatchChanges()" class="px-6 py-2.5 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-highest transition-colors font-label-md">Discard Changes</button>
        <button onclick="saveBatchChanges()" class="px-6 py-2.5 bg-primary text-on-primary rounded-lg shadow-sm hover:shadow transition-shadow font-label-md flex items-center gap-2">
            <span class="material-symbols-outlined" style="font-size: 18px;">save</span>
            Save Changes
        </button>
    </div>
</div>

<script>
window.pendingChanges = [];

function updateBatchEditBar() {
    const bar = document.getElementById('batchEditBar');
    const countText = document.getElementById('batchEditCount');
    if (window.pendingChanges.length > 0) {
        bar.classList.remove('translate-y-full');
        countText.innerText = `You have ${window.pendingChanges.length} pending changes.`;
    } else {
        bar.classList.add('translate-y-full');
    }
}

function cancelBatchChanges() {
    if(confirm('Are you sure you want to discard all unsaved changes?')) {
        window.pendingChanges = [];
        window.location.reload();
    }
}

async function saveBatchChanges() {
    const bar = document.getElementById('batchEditBar');
    bar.style.opacity = '0.5';
    bar.style.pointerEvents = 'none';
    
    try {
        for (let change of window.pendingChanges) {
            if (change.action === 'delete') {
                await fetch(change.url, { method: 'GET' });
            } else if (change.action === 'save') {
                const formData = new FormData();
                for(let key in change.data) formData.append(key, change.data[key]);
                await fetch(change.url, {
                    method: 'POST',
                    body: formData
                });
            }
        }
        window.pendingChanges = [];
        window.location.reload();
    } catch (e) {
        alert('An error occurred while saving changes.');
        bar.style.opacity = '1';
        bar.style.pointerEvents = 'auto';
    }
}

window.addEventListener('beforeunload', function (e) {
    if (window.pendingChanges.length > 0) {
        var confirmationMessage = 'You have unsaved changes. Are you sure you want to leave?';
        (e || window.event).returnValue = confirmationMessage; 
        return confirmationMessage;
    }
});

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('nav a').forEach(a => {
        a.addEventListener('click', function(e) {
            if (window.pendingChanges.length > 0) {
                if(!confirm('You have unsaved changes. Are you sure you want to navigate away and discard them?')) {
                    e.preventDefault();
                }
            }
        });
    });
});
</script>

<script>
// Global Search Logic
function globalSearchComponent() {
    return {
        query: '',
        results: [],
        open: false,
        loading: false,
        async fetchResults() {
            if (this.query.trim().length < 1) {
                this.results = [];
                this.open = false;
                return;
            }
            this.loading = true;
            this.open = true;
            try {
                const response = await fetch('/admin/search?q=' + encodeURIComponent(this.query));
                this.results = await response.json();
            } catch (error) {
                console.error('Search failed:', error);
                this.results = [];
            }
            this.loading = false;
        },
        getIcon(type) {
            if (type === 'product') return 'inventory_2';
            if (type === 'user') return 'person';
            if (type === 'order') return 'receipt_long';
            return 'search';
        }
    }
}

// Global Pagination Logic
function setupPagination(tableId, paginationContainerId, rowsPerPage = 10, rowClass = '.paginate-row', itemType = 'items') {
    const table = document.getElementById(tableId);
    if (!table) return;

    // Get only rows that are not filtered out by search/status
    const allRows = Array.from(table.querySelectorAll(rowClass));
    const visibleRows = allRows.filter(row => row.style.display !== 'none' && !row.classList.contains('hidden-by-filter'));
    
    const totalRows = visibleRows.length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);
    let currentPage = 1;

    // We store currentPage on the table element to remember state between filter changes
    if (table.dataset.currentPage) {
        currentPage = parseInt(table.dataset.currentPage);
        if (currentPage > totalPages) currentPage = Math.max(1, totalPages);
    }

    table.dataset.currentPage = currentPage;

    function render() {
        const startIndex = (currentPage - 1) * rowsPerPage;
        const endIndex = startIndex + rowsPerPage;

        // Hide all visibleRows first, then show only the ones for this page
        visibleRows.forEach((row, index) => {
            if (index >= startIndex && index < endIndex) {
                row.style.display = ''; // Reset display so it shows
                row.classList.remove('hidden-by-pagination');
            } else {
                row.style.display = 'none';
                row.classList.add('hidden-by-pagination');
            }
        });

        renderPaginationUI();
    }

    function renderPaginationUI() {
        const container = document.getElementById(paginationContainerId);
        if (!container) return;

        const startDisplay = totalRows === 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1;
        const endDisplay = Math.min(currentPage * rowsPerPage, totalRows);

        let html = `
        <div class="font-body-md text-body-md text-on-surface-variant">
            Showing <span class="font-medium text-on-surface">${startDisplay}</span> to <span class="font-medium text-on-surface">${endDisplay}</span> of <span class="font-medium text-on-surface">${totalRows}</span> ${itemType}
        </div>
        <div class="flex gap-1">
            <button onclick="changePage('${tableId}', ${currentPage - 1})" class="p-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low disabled:opacity-50 disabled:cursor-not-allowed transition-colors" ${currentPage === 1 ? 'disabled' : ''}>
                <span class="material-symbols-outlined" style="font-size: 20px;">chevron_left</span>
            </button>
        `;

        // Logic for page numbers (simplified to show up to 5 buttons max to avoid stretching)
        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(totalPages, startPage + 4);
        
        if (endPage - startPage < 4) {
            startPage = Math.max(1, endPage - 4);
        }

        if (startPage > 1) {
            html += `<button onclick="changePage('${tableId}', 1)" class="w-10 h-10 border border-outline-variant text-on-surface-variant rounded-lg font-title-md text-title-md hover:bg-surface-container-low transition-colors">1</button>`;
            if (startPage > 2) html += `<span class="w-10 h-10 flex items-center justify-center text-on-surface-variant">...</span>`;
        }

        for (let i = startPage; i <= endPage; i++) {
            if (i === currentPage) {
                html += `<button class="w-10 h-10 border border-primary bg-primary-container/10 text-primary rounded-lg font-title-md text-title-md hover:bg-primary-container/20 transition-colors">${i}</button>`;
            } else {
                html += `<button onclick="changePage('${tableId}', ${i})" class="w-10 h-10 border border-outline-variant text-on-surface-variant rounded-lg font-title-md text-title-md hover:bg-surface-container-low transition-colors">${i}</button>`;
            }
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) html += `<span class="w-10 h-10 flex items-center justify-center text-on-surface-variant">...</span>`;
            html += `<button onclick="changePage('${tableId}', ${totalPages})" class="w-10 h-10 border border-outline-variant text-on-surface-variant rounded-lg font-title-md text-title-md hover:bg-surface-container-low transition-colors">${totalPages}</button>`;
        }

        html += `
            <button onclick="changePage('${tableId}', ${currentPage + 1})" class="p-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low disabled:opacity-50 disabled:cursor-not-allowed transition-colors" ${currentPage === totalPages || totalPages === 0 ? 'disabled' : ''}>
                <span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
            </button>
        </div>`;

        container.innerHTML = html;
    }

    render();
}

// Global function to trigger page change
window.changePage = function(tableId, newPage) {
    const table = document.getElementById(tableId);
    if (table) {
        table.dataset.currentPage = newPage;
        // Re-trigger the setup to re-render. 
        // We look for a data attribute to know which container and config to use
        const config = JSON.parse(table.dataset.paginationConfig || '{}');
        setupPagination(tableId, config.containerId || 'paginationContainer', config.rowsPerPage || 10, config.rowClass || '.paginate-row', config.itemType || 'items');
    }
}
</script>
</body></html>
