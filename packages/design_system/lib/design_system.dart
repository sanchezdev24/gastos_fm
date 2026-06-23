/// Shoppe Design System
/// ─────────────────────────────────────────────────────────────────────────────
/// Atomic design system for the Shoppe eCommerce app.
/// Built on top of shadcn_ui ^0.52.1 + Flutter Material 3.
///
/// ## Usage
/// ```dart
/// import 'package:your_app/design_system/design_system.dart';
/// ```
///
/// ## Architecture (Atomic Design)
///
///  Tokens ──► Atoms ──► Molecules ──► Organisms ──► Templates / Pages
///
/// ### Tokens (design primitives)
/// - [ShoppeColors]     — brand palette, semantic, neutrals
/// - [ShoppeTypography] — text styles (display → body → badge)
/// - [ShoppeSpacing]    — 4px-based spacing scale
/// - [ShoppeRadius]     — border radius values + BorderRadius shortcuts
/// - [ShoppeShadows]    — box shadow presets
/// - [ShoppeDurations]  — animation durations
/// - [ShoppeCurves]     — animation curves
/// - [ShoppeIconSizes]  — icon size constants
///
/// ### Atoms (smallest UI units)
/// - [ShoppeButton]           — primary / secondary / ghost / danger
/// - [ShoppeCircleIconButton] — blue circle with icon (→ arrows)
/// - [ShoppeTextField]        — standard + password toggle
/// - [ShoppePinDot]           — single PIN/OTP dot (empty / filled / error)
/// - [ShoppePinRow]           — full PIN dot row
/// - [ShoppeDiscountBadge]    — "-20%" corner badge
/// - [ShoppeTag]              — Live / New / Sale / Hot inline tag
/// - [ShoppeAvatar]           — circular avatar with optional ring
/// - [ShoppeFilterChip]       — discount filter chip (All / 10% / 20%...)
/// - [ShoppePageDots]         — carousel dot indicator
/// - [ShoppeDivider]          — 1px divider
/// - [ShoppeDecorativeBlob]   — organic blue blob background element
///
/// ### Molecules (composed from atoms)
/// - [ShoppeProductCard]        — image + name + price (with badge)
/// - [ShoppePriceDisplay]       — current + strike-through price
/// - [ShoppeCategoryCard]       — 2×2 grid image card + title + count
/// - [ShoppeFlashSaleTimer]     — countdown "⏱ 00 36 58"
/// - [ShoppePopularItem]        — avatar + count + tag for Most Popular
/// - [ShoppeStoryCard]          — story card with Live/play overlay
/// - [ShoppeSectionHeader]      — title + "See All →" row
/// - [ShoppeAnnouncementBanner] — grey announcement card
/// - [ShoppeOrderChips]         — To Pay / To Receive / To Review
/// - [ShoppeRecoveryOption]     — SMS / Email password recovery tile
/// - [ShoppeSearchBar]          — search field with icon
/// - [ShoppePromoBanner]        — yellow Big Sale hero card
///
/// ### Organisms (functional sections)
/// - [ShoppeBottomNavBar]       — 5-tab bottom navigation
/// - [ShoppeHeroSlider]         — banner carousel with dots
/// - [ShoppeProductGrid]        — 2-col product grid
/// - [ShoppeProductRow]         — horizontal product scroll
/// - [ShoppeFlashSaleSection]   — full flash sale block (timer + filter + grid)
/// - [ShoppeStoriesRow]         — horizontal stories strip
/// - [ShoppeAuthBackground]     — auth screen scaffold with blobs
/// - [ShoppeLiveViewerBar]      — live stream bottom action bar
/// - [ShoppeProfileHeader]      — profile screen top bar
/// - [ShoppeMaxAttemptsDialog]  — max OTP attempts modal
///
/// ### Theme
/// - [ShoppeTheme]              — ShadThemeData (light / dark)
/// - [shoppeFlutterTheme]       — MaterialThemeData for non-shadcn widgets

library shoppe_design_system;

// Tokens
export 'tokens/shoppe_colors.dart';
export 'tokens/shoppe_typography.dart';
export 'tokens/shoppe_tokens.dart';

// Theme
export 'theme/shoppe_theme.dart';

// Atoms
export 'atoms/shoppe_atoms.dart';

// Molecules
export 'molecules/shoppe_molecules.dart';

// Organisms
export 'organisms/shoppe_organisms.dart';
