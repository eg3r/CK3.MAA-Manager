# Graphics Assets - Foundation Setup

This folder contains the graphics assets for the Men-At-Arms Manager mod.

## Current Status: Foundation Setup

During the foundation phase, we're using placeholder files and CK3's built-in graphics.

## Folder Structure

```
gfx/interface/
├── men_at_arms_manager/     # Custom graphics for the manager window
│   ├── window_background.dds      # (Future) Custom window background
│   ├── transfer_arrow_left.dds    # (Future) Left transfer arrow
│   ├── transfer_arrow_right.dds   # (Future) Right transfer arrow
│   └── unit_card_background.dds   # (Future) Unit card background
└── icons/                   # Icon graphics
    └── manage_maa_button.dds      # (Future) Military menu button icon
```

## Graphics To Be Created

### Phase 1 - Basic Graphics (Milestone 2)
- Military menu button icon (24x24, 32x32, 48x48 variants)
- Basic transfer arrow icons

### Phase 2 - Enhanced Graphics (Milestone 5)
- Custom window backgrounds with medieval theme
- Unit card backgrounds and borders
- Selection highlight graphics
- Drag & drop visual feedback elements

### Phase 3 - Polish Graphics (Milestone 6)
- Animated elements
- High-resolution variants
- Accessibility-focused variants

## Using Built-in CK3 Graphics

For the foundation setup, we rely on CK3's built-in graphics system:
- `using = Window_Background` for window backgrounds
- `using = Background_Area` for content areas
- `button_standard` and `button_close` for buttons
- Standard CK3 icons and decorations

## Notes for Artists

- All graphics should match CK3's medieval aesthetic
- Use CK3's color palette for consistency
- DDS format required for textures
- Multiple resolutions needed for different UI scales
- Alpha channels for transparency effects

## Current Dependencies

Foundation setup uses only CK3 built-in graphics:
- No custom graphics files needed yet
- All styling through CK3's standard templates
- Future custom graphics will enhance visual appeal