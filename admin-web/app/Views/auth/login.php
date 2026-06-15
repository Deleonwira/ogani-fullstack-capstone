<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ogani Admin - Login</title>
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#4CAF50',
                        'primary-container': '#C8E6C9',
                        'on-primary': '#FFFFFF',
                        'on-primary-container': '#1B5E20',
                        surface: '#F8FAF8',
                        'surface-bright': '#FFFFFF',
                        'surface-container-lowest': '#FFFFFF',
                        'surface-container-low': '#F3F6F3',
                        'surface-container': '#EDF1ED',
                        'surface-container-high': '#E8ECE8',
                        'surface-container-highest': '#E2E6E2',
                        'on-surface': '#1A1C19',
                        'on-surface-variant': '#424940',
                        outline: '#72796F',
                        'outline-variant': '#C2C9BD',
                        error: '#BA1A1A',
                        'error-container': '#FFDAD6',
                        'on-error': '#FFFFFF',
                        'on-error-container': '#410002',
                    },
                    fontFamily: {
                        display: ['Outfit', 'sans-serif'],
                        body: ['"Plus Jakarta Sans"', 'sans-serif'],
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-surface font-body text-on-surface h-screen flex items-center justify-center p-4">
    <div class="bg-surface-container-lowest w-full max-w-md rounded-2xl shadow-lg border border-outline-variant/30 p-8">
        <div class="flex items-center justify-center mb-8">
            <div class="w-12 h-12 flex items-center justify-center text-primary mr-3 flex-shrink-0">
                <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-full h-full">
                    <path d="M 15 35 h 15 v 25 q 0 10 10 10 h 30 q 15 0 15 -15 v -5 q 0 -15 -15 -15 h -25" stroke="currentColor" stroke-width="12" stroke-linecap="round" stroke-linejoin="round"/>
                    <circle cx="45" cy="88" r="8" fill="currentColor"/>
                    <circle cx="70" cy="88" r="8" fill="currentColor"/>
                </svg>
            </div>
            <h1 class="font-display font-bold text-3xl tracking-tight text-on-surface">Ogani<span class="text-primary">Admin</span></h1>
        </div>

        <h2 class="text-title-lg font-display font-semibold text-center mb-6 text-on-surface">Sign in to your account</h2>

        <?php if(session()->getFlashdata('error')): ?>
            <div class="bg-error-container text-on-error-container p-4 rounded-lg mb-6 flex items-center gap-3">
                <span class="material-symbols-outlined">error</span>
                <p class="font-body text-sm font-medium"><?= esc(session()->getFlashdata('error')) ?></p>
            </div>
        <?php endif; ?>

        <form action="<?= base_url('auth/loginProcess') ?>" method="POST" class="space-y-5">
            <div>
                <label for="email" class="block text-sm font-medium text-on-surface-variant mb-1">Email Address</label>
                <div class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline">mail</span>
                    <input type="email" id="email" name="email" required 
                           class="w-full pl-10 pr-4 py-2.5 bg-surface-container-low border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-primary focus:bg-surface-container-lowest outline-none transition-all text-on-surface placeholder:text-outline"
                           placeholder="admin@ogani.com">
                </div>
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-on-surface-variant mb-1">Password</label>
                <div class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline">lock</span>
                    <input type="password" id="password" name="password" required 
                           class="w-full pl-10 pr-4 py-2.5 bg-surface-container-low border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-primary focus:bg-surface-container-lowest outline-none transition-all text-on-surface placeholder:text-outline"
                           placeholder="••••••••">
                </div>
            </div>

            <button type="submit" class="w-full bg-primary hover:bg-[#388E3C] text-on-primary font-medium py-2.5 rounded-lg transition-colors shadow-sm flex justify-center items-center gap-2 mt-4">
                Sign In
                <span class="material-symbols-outlined" style="font-size: 20px;">login</span>
            </button>
        </form>
    </div>
</body>
</html>
