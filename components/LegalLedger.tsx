import { DossierNav } from '@/components/DossierNav'
import { DlFooter } from '@/components/DlFooter'

type LegalSection = { title: string; body: string }

export function LegalLedger({
  eyebrow,
  title,
  summary,
  updated,
  sections,
}: {
  eyebrow: string
  title: string
  summary: string
  updated: string
  sections: LegalSection[]
}) {
  return (
    <div className="legal-ledger">
      <DossierNav />
      <main className="legal-ledger-main">
        <header className="legal-ledger-header">
          <div>
            <span className="legal-ledger-eyebrow">{eyebrow}</span>
            <h1>{title}</h1>
          </div>
          <div className="legal-ledger-summary">
            <p>{summary}</p>
            <span>Last updated · {updated}</span>
          </div>
        </header>

        <div className="legal-ledger-grid">
          <aside aria-label={`${title} contents`}>
            <span>Contents</span>
            <ol>
              {sections.map((section, index) => (
                <li key={section.title}>
                  <a href={`#section-${index + 1}`}>
                    <b>{String(index + 1).padStart(2, '0')}</b>
                    {section.title}
                  </a>
                </li>
              ))}
            </ol>
          </aside>

          <section className="legal-ledger-copy">
            {sections.map((section, index) => (
              <article id={`section-${index + 1}`} key={section.title}>
                <span>{String(index + 1).padStart(2, '0')}</span>
                <div>
                  <h2>{section.title}</h2>
                  <p>{section.body}</p>
                </div>
              </article>
            ))}
          </section>
        </div>
      </main>
      <DlFooter />
    </div>
  )
}
