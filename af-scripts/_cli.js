// @ts-check

/** @type {(argv: string[], positionalDefaults: string[], flagDefaults: {}) => { positionalArgs: string[], flags: {[k: string]: string}}} */
exports.parseCLI = (argv, positionalDefaults = [], flagDefaults = {}) => {
  const params = argv.slice(2)

  /** @type {{[k: string]: string}} */
  const parsedFlags = {}
  const parsedPositionals = []
  let queuedFlagName = null

  for (const p of params) {
    const isFlag = p.startsWith('--')
    if (isFlag) {
      if (queuedFlagName) throw new Error(`Missing value for flag ${queuedFlagName}`)
      queuedFlagName = p.slice(2)
    } else {
      if (queuedFlagName) {
        parsedFlags[queuedFlagName] = p
        queuedFlagName = null
      }
      else parsedPositionals.push(p)
    }
  }
  const positionalArgs = positionalDefaults.map((defaultVal, idx) => parsedPositionals[idx] || defaultVal)
  const flags = { ...flagDefaults, ...parsedFlags }
  return { positionalArgs, flags }
}

// Quick and dirty terminal colorize utils.
// See https://stackoverflow.com/questions/9781218/how-to-change-node-jss-console-font-color
//
/** @type {(colorCode: string) => (str: string) => string} */
const _makeColorizer = colorCode => str => `\x1b[${colorCode}m${str}\x1b[0m`
exports.colorize = {
  blue: _makeColorizer('34'),
  cyan: _makeColorizer('36'),
  yellow: _makeColorizer('33'),
}

