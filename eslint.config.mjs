import nextVitals from 'eslint-config-next/core-web-vitals'
import nextTs from 'eslint-config-next/typescript'

const config = [
  ...nextVitals,
  ...nextTs,
  {
    ignores: [
      '.next/**',
      'node_modules/**',
      'out/**',
      'build/**',
      'next-env.d.ts',
    ],
  },
    {
      rules: {
        '@next/next/no-img-element': 'off',
        '@next/next/no-page-custom-font': 'off',
        '@next/next/no-html-link-for-pages': 'off',
        'react-hooks/set-state-in-effect': 'off',
      },
    },
]

export default config
