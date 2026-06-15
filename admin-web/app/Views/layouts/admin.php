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
<body class="bg-background text-on-background min-h-screen font-body-md text-body-md overflow-x-hidden selection:bg-primary-container selection:text-on-primary-container">
<!-- SideNavBar -->
<nav aria-label="Sidebar Navigation" class="fixed left-0 top-0 h-screen w-[260px] bg-surface-container-lowest border-r border-outline-variant shadow-sm z-50 flex flex-col py-gutter px-4">
<!-- Header -->
<div class="mb-8 px-4 flex items-center gap-3">
<div class="w-10 h-10 flex items-center justify-center text-primary flex-shrink-0">
    <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-full h-full">
        <path d="M 15 35 h 15 v 25 q 0 10 10 10 h 30 q 15 0 15 -15 v -5 q 0 -15 -15 -15 h -25" stroke="currentColor" stroke-width="12" stroke-linecap="round" stroke-linejoin="round"/>
        <circle cx="45" cy="88" r="8" fill="currentColor"/>
        <circle cx="70" cy="88" r="8" fill="currentColor"/>
    </svg>
</div>
<div>
<h1 class="text-title-lg font-title-lg font-bold text-primary tracking-tight">Ogani Admin</h1>
<p class="text-label-sm font-label-sm text-on-surface-variant">Management Portal</p>
</div>
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
<div class="ml-[260px] min-h-screen flex flex-col">
<!-- TopNavBar -->
<header class="fixed top-0 right-0 h-topbar-height z-40 flex justify-between items-center w-[calc(100%-260px)] px-gutter bg-surface-container-lowest border-b border-outline-variant transition-all">
<!-- Search (Left Aligned) -->
<div class="flex-1 max-w-md">
<div class="relative group">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">search</span>
<input class="w-full h-10 pl-10 pr-4 bg-surface-container-low border border-transparent rounded-full font-body-md text-body-md text-on-surface placeholder:text-outline focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all bg-opacity-50" placeholder="Search orders, customers, or products..." type="text"/>
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
<main class="flex-1 pt-[calc(72px+32px)] px-container-padding pb-container-padding max-w-[1600px] mx-auto w-full">
<?= $this->renderSection('content') ?>
</main>
</div>
</body></html>
