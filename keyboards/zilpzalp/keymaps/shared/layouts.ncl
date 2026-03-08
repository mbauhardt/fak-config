let { tap, hold, .. } = import "fak/keycode.ncl" in
let util = import "fak/util_functions.ncl" in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let me = tap.custom.media in
let XXXX = tap.none & hold.none in

let shared_layers = {
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
    ks.LCBR,
  ],
  NUM = [
            kc.N7, kc.N8,   kc.N9,   kc.RBRC,       XXXX,    XXXX,    XXXX,    XXXX,
   kc.SCLN, kc.N4, kc.N5,   kc.N6,   kc.EQL,       XXXX,    md.lsft, md.lctl, md.lalt, md.lgui,
            kc.N1, kc.N2,   kc.N3,                        XXXX,    XXXX,    XXXX,
                            kc.N0,   kc.MINS,        kc.E,    kc.N0,
  ],
} in

let both_side_combos = [
  # [CW, 10, 13],
] in

{
  qwerty = {
    base_layout = "WERTYUIOSDFGHJKLAXCVM,.P",
    thumbs = [kc.ESC, kc.SPC, kc.N, kc.ENT],
    combos = [
      # Left
      [kc.Q,    0,  1],
      [kc.Z,    17, 18], [kc.B,    18, 19],
      # Right
                                            [kc.QUOT, 5, 6],   [kc.SCLN, 6,  7],
                                            [kc.MINS, 20, 21], [kc.SLSH, 21, 22],
    ] @ both_side_combos,
    layers = {
      NAV = shared_layers.NAV,
      FUN = shared_layers.FUN,
      SYM = shared_layers.SYM,
      NUM = shared_layers.NUM,
    }
  },

  colemak = {
    base_layout = "WFPKJLUYRSTGMNEIAXCDH,.O",
    thumbs = [kc.ESC, kc.SPC, kc.ENT, kc.BSPC],
    combos = [
      # Left
      [kc.Q,    0,  1],  [kc.B,    1,  2],
      [kc.Z,    17, 18], [kc.V,    18, 19],
      # Right
                                            [kc.QUOT, 5, 6],   [kc.SCLN, 6,  7],
                                            [kc.MINS, 20, 21], [kc.SLSH, 21, 22],
    ] @ both_side_combos,
    layers = {
      NAV = shared_layers.NAV,
      FUN = shared_layers.FUN,
      SYM = shared_layers.SYM,
      NUM = shared_layers.NUM,
    }
  },

  aptmak = {
    base_layout = "WFPBJLUYSTHKXNAIRCGDM,.O",
    thumbs = [kc.QUOT, kc.SPC, kc.E, kc.ENT],
    combos = [
      # Left
      [kc.V,    0,  1],  [kc.Q,    1,  2],
      [ks.LCBR, 0,  8],  [kc.LBRC, 1,  9],  [ks.LPRN, 2,  10], [ks.LABK, 3,  11],
      [kc.Z,    17, 18], [kc.ESC,  18, 19],
      # Right
                                            [tm.lctl & kc.BSPC, 5, 7],
                                            [kc.BSPC, 5, 6],   [kc.DEL,  6,  7],
      [ks.RABK, 4,  12], [ks.RPRN, 5,  13], [kc.RBRC, 6,  14], [ks.RCBR, 7,  15],
                                            [kc.MINS, 20, 21], [kc.SLSH, 21, 22],
    ] @ both_side_combos,
    layers = {
      NAV = shared_layers.NAV,
      FUN = shared_layers.FUN,
      SYM = shared_layers.SYM,
      NUM = shared_layers.NUM,
    },
  },

  dvorak = {
    #  ',.py   fgcrl       ,.py   fgcr
    #  aoeui   dhtns  ==>  oeui   dhtn
    #  /qjkx   bmwvz      aqjkx   mwvzs

    base_layout = ",.PYFGCRAOEUIDHTNSQJKMWV",

    thumbs = [kc.ESC, kc.TAB, kc.ENT, kc.SPC],
    combos = [
      # Left
      [kc.QUOT, 0,  1],
      [kc.SLASH, 18, 19], [kc.X,  19, 20],
      # Right
                                            [kc.L, 6, 7],
                                            [kc.B, 21, 22], [kc.Z, 22, 23],
    ] @ both_side_combos,
    layers = {
      NAV = shared_layers.NAV,
      FUN = shared_layers.FUN,
      SYM = shared_layers.SYM,
      NUM = shared_layers.NUM,
    },
  },
}
