let { tap, hold, td, combo, .. } = import "fak/keycode.ncl" in
let util = import "fak/util_functions.ncl" in
let config = import "config.ncl" in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let me = tap.custom.media in
let XXXX = tap.none & hold.none in

let layout = {
  base_layout = ",.PYFGCRAOEUIDHTNSQJKMWV",
  thumbs = [kc.ESC, kc.TAB, kc.ENT, kc.SPC],
  combos = [
    # Left
    [kc.QUOT, 0,  1],
    [kc.SLASH, 18, 19], [kc.X,  19, 20],
    # Right
    [kc.L, 6, 7],
    [kc.B, 21, 22], [kc.Z, 22, 23],
  ],
  layers = {
    NAV = [
              XXXX,    XXXX,    XXXX,    XXXX,        kc.PGUP,  XXXX,    XXXX,    XXXX,
     md.lgui, md.lalt, md.lctl, md.lsft, XXXX,        kc.PGDN,  kc.LEFT, kc.DOWN, kc.UP,     kc.RGHT,
              XXXX,    XXXX,    XXXX,                           kc.HOME, kc.DEL,  kc.END,
                                XXXX,    XXXX,        XXXX,  kc.BSPC,
    ],
    FUN = [
              XXXX,    XXXX,    XXXX,    XXXX,        kc.F12,  kc.F7,   kc.F8,   kc.F9,
      XXXX,   XXXX,    XXXX,    XXXX,    XXXX,        kc.F11,  kc.F4,   kc.F5,   kc.F6,  kc.F10,
              XXXX,    XXXX,    XXXX,                          kc.F1,   kc.F2,   kc.F3,
                                XXXX,    XXXX,        XXXX,    XXXX,
    ],
    SYM = [
      ks.AMPR,  ks.ASTR, ks.LPRN,  ks.RCBR,     XXXX, XXXX, XXXX, XXXX,
      ks.COLN, ks.DLR,   ks.PERC, ks.CIRC,  ks.PLUS,     XXXX, XXXX, XXXX, XXXX, XXXX,
              ks.EXLM,  ks.AT,   ks.HASH,                   XXXX,    XXXX,    XXXX,
                              ks.RPRN, ks.UNDS,     XXXX,    XXXX,
    ],
    NUM = [
              kc.N7, kc.N8,   kc.N9,   kc.RBRC,       XXXX,    XXXX,    XXXX,    XXXX,
     kc.SCLN, kc.N4, kc.N5,   kc.N6,   kc.EQL,       XXXX,    md.lsft, md.lctl, md.lalt, md.lgui,
              kc.N1, kc.N2,   kc.N3,                        XXXX,    XXXX,    XXXX,
                              kc.N0,   kc.MINS,        kc.E,    kc.N0,
    ],
  },
} in

let ki = {
  hp = { decision = 'hold, trigger_on = 'press },
  tp = { decision = 'tap, trigger_on = 'press },
  hr = { decision = 'hold, trigger_on = 'release },
  tr = { decision = 'tap, trigger_on = 'release },
  xx = { decision = 'none },
} in

let combos = layout.combos in
let virtual_keys' =
  combos |> std.array.map (fun c =>
    combo.make config.combo_timeout_ms (std.array.split_at 1 c).right)
in

let physical_key_count = 28 in
let virtual_key_count = std.array.length virtual_keys' in
let key_count = physical_key_count + virtual_key_count in

let htb_hrm_base = {
  timeout_ms = 200,
  quick_tap_ms = 150,
  quick_tap_interrupt_ms = 500,
  global_quick_tap_ms = 100,
} in

let htb_hrm_left = htb_hrm_base & {
  key_interrupts = [
    ki.tp, ki.tp, ki.tp, ki.tp,    ki.hr, ki.hr, ki.hr, ki.hr,
    ki.tr, ki.tr, ki.tr, ki.tr,    ki.hr, ki.hr, ki.hr, ki.hr,
    ki.tp, ki.tp, ki.tp, ki.tp,    ki.hr, ki.hr, ki.hr, ki.hr,
    ki.tp, ki.tp,                  ki.hr, ki.hr,
  ] @ (std.array.replicate virtual_key_count ki.xx)
} in

let htb_hrm_right = htb_hrm_base & {
  key_interrupts = [
    ki.hr, ki.hr, ki.hr, ki.hr,    ki.tp, ki.tp, ki.tp, ki.tp,
    ki.hr, ki.hr, ki.hr, ki.hr,    ki.tr, ki.tr, ki.tr, ki.tr,
    ki.hr, ki.hr, ki.hr, ki.hr,    ki.tp, ki.tp, ki.tp, ki.tp,
    ki.hr, ki.hr,                  ki.tp, ki.tp,
  ] @ (std.array.replicate virtual_key_count ki.xx)
} in

let make_hrm = fun key_idx =>
  let hrm_mods = [
    md.lgui, md.lalt, md.lctl, md.lsft,
    md.rsft, md.rctl, md.lalt, md.rgui
  ] in
  let hrm_key_indices = [
    8, 9, 10, 11,
    12, 13, 14, 15
  ] in

  if std.array.elem key_idx hrm_key_indices then
    let mod_idx = util.array.index_of key_idx hrm_key_indices in
    let mod = std.array.at mod_idx hrm_mods in
    let side = if mod_idx < 4 then 'left else 'right in
    mod & hold.reg.behavior (if side == 'left then htb_hrm_left else htb_hrm_right)
  else
    {}
in

let virtual_base = combos |> std.array.map std.array.first in
let virtual_filler = combos |> std.array.map (fun c => XXXX) in

let layer_default =
  let base_keycodes = layout.base_layout
    |> std.string.characters
    |> util.array.enumerate
    |> std.array.map (fun { index, value } => tap.reg.kc."%{value}" & make_hrm index)
  in

  let thumb_keycodes =
    let htb_thumb = {
      timeout_ms = 200,
      quick_tap_ms = 150,
      quick_tap_interrupt_ms = 500,
      key_interrupts = std.array.replicate key_count ki.hr,
    } in

    layout.thumbs
    |> util.array.enumerate
    |> std.array.map (fun { index, value } =>
        value
        & hold.reg.layer (index + 1)
        & hold.reg.behavior htb_thumb)
  in

  base_keycodes @ thumb_keycodes @ virtual_base
in

{
  virtual_keys = virtual_keys',
  layers = [layer_default] @ (
    ["NAV", "FUN", "SYM", "NUM"]
    |> std.array.map (fun name => layout.layers."%{name}")
    |> std.array.map (fun layer => layer @ virtual_filler)
  )
}
