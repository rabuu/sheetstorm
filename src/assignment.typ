#import "header.typ": header-content
#import "widgets.typ"
#import "i18n.typ"
#import "util.typ": is-some

/// Setup the document as an assignment sheet.
///
/// This is the main "entrypoint" for the template.
/// Apply this function with a show everything rule to use it:
/// ```
/// #show: assignment.with(
///   title: "A cool title",
///   page-numbering: "1",
/// )
/// ```
///
/// Here you can set many options to customize the template settings.
/// For general page settings, prefer to set it using this function if available.
#let assignment(
  course: none,
  authors: none,
  tutor: none,
  title: none,
  title-default-styling: true,
  title-size: 1.6em,
  margin-left: 1.7cm,
  margin-right: 1.7cm,
  margin-bottom: 1.7cm,
  margin-above-header: 0cm,
  margin-below-header: 0cm,
  paper: "a4",
  page-numbering: "1 / 1",
  date: datetime.today(),
  date-format: auto,
  header-show-title-on-first-page: false,
  header-extra-left: none,
  header-extra-center: none,
  header-extra-right: none,
  header-tutor-prefix: context i18n.word("Tutor"),
  header-columns: (1fr, 1.25fr, 1fr),
  header-align: (left, center, right),
  header-column-gutter: 0.5em,
  header-row-gutter: 0.5em,
  header-padding-top: 0.8cm,
  header-padding-bottom: 1cm,
  initial-task-number: 1,
  widget-order-reversed: false,
  widget-column-gap: 4em,
  widget-row-gap: 1em,
  widget-spacing-above: 0em,
  widget-spacing-below: 1em,
  score-box-enabled: false,
  score-box-tasks: none,
  score-box-show-points: true,
  score-box-bonus-counts-for-sum: false,
  score-box-bonus-show-star: true,
  score-box-inset: 0.7em,
  score-box-cell-width: 4.5em,
  info-box-enabled: false,
  info-box-show-ids: true,
  info-box-show-emails: true,
  info-box-inset: 0.7em,
  info-box-gutter: 1em,
  hyperlink-style: underline,
  doc,
) = {
  let author-names
  let author-ids
  let author-emails
  let has-ids = false
  let has-emails = false

  if authors != none {
    if type(authors) != array { authors = (authors,) }

    author-names = authors.map(a => if type(a) == dictionary
      and "name" in a [ #a.name ] else if a != none [ #a ])

    author-ids = authors.map(a => if type(a) == dictionary
      and "id" in a [ #a.id ])
    author-emails = authors.map(a => if type(a) == dictionary
      and "email" in a [ #a.email ])

    if author-ids != none { has-ids = author-ids.filter(is-some).len() > 0 }
    if author-emails != none {
      has-emails = author-emails.filter(is-some).len() > 0
    }
  }

  let header = header-content(
    course,
    title,
    author-names,
    date,
    date-format,
    tutor,
    header-tutor-prefix,
    header-show-title-on-first-page,
    header-extra-left,
    header-extra-center,
    header-extra-right,
    header-columns,
    header-align,
    header-column-gutter,
    header-row-gutter,
    header-padding-top,
    header-padding-bottom,
  )

  context {
    //
    // SETTINGS
    //

    let header-height = measure(
      width: page.width - margin-left - margin-right,
      header,
    ).height

    set page(
      paper: paper,
      numbering: page-numbering,
      margin: (
        top: header-height + margin-above-header,
        bottom: margin-bottom,
        left: margin-left,
        right: margin-right,
      ),
      header: header,
      header-ascent: 0pt,
    )

    set par(
      first-line-indent: 1em,
      justify: true,
    )

    show ref: it => {
      let el = it.element

      if el.func() == figure and el.kind == "sheetstorm-task-label" {
        let task-count = counter("sheetstorm-task").at(el.location()).first()
        let supp = if it.supplement == auto {
          el.supplement
        } else {
          it.supplement
        }
        link(el.location())[#supp #task-count]
      } else if el.func() == figure and el.kind == "sheetstorm-subtask-label" {
        link(el.location(), el.supplement)
      } else if el.func() == figure and el.kind == "sheetstorm-theorem-label" {
        let theorem-id = state("sheetstorm-theorem-id").at(el.location())
        if theorem-id == auto {
          theorem-id = counter("sheetstorm-theorem-count")
            .at(el.location())
            .first()
        }
        if theorem-id == none {
          panic(
            "This theorem is not referencable. Provide a name or numbering.",
          )
        }
        let supp = if it.supplement == auto {
          el.supplement
        } else {
          it.supplement
        }
        link(el.location())[#supp #theorem-id]
      } else {
        it
      }
    }

    show link: it => {
      if type(it.dest) == str {
        return hyperlink-style(it)
      } else {
        return it
      }
    }

    //
    // COUNTERS
    //

    counter("sheetstorm-task").update(initial-task-number)
    counter("sheetstorm-theorem-count").update(1)
    counter("sheetstorm-todo").update(0)

    //
    // SPACING BELOW HEADER
    //
    v(margin-below-header)

    //
    // WIDGETS
    // (info box & score box)
    //

    let info-box-enabled = info-box-enabled and author-names != none

    let widget-number = (score-box-enabled, info-box-enabled)
      .map(x => if x { 1 } else { 0 })
      .sum()

    let info-box = if info-box-enabled {
      widgets.info-box(
        author-names,
        student-ids: if info-box-show-ids and has-ids { author-ids },
        emails: if info-box-show-emails and has-emails { author-emails },
        inset: info-box-inset,
        gutter: info-box-gutter,
      )
    }

    let score-box = if score-box-enabled {
      widgets.score-box(
        tasks: score-box-tasks,
        show-points: score-box-show-points,
        bonus-counts-for-sum: score-box-bonus-counts-for-sum,
        bonus-show-star: score-box-bonus-show-star,
        inset: score-box-inset,
        cell-width: score-box-cell-width,
      )
    }

    if score-box-enabled or info-box-enabled {
      let display-widgets = if not widget-order-reversed {
        (info-box, score-box)
      } else {
        (score-box, info-box)
      }.filter(is-some)

      v(widget-spacing-above)

      layout(size => {
        let (columns, alignment) = {
          if widget-number == 1 {
            (1, center + horizon)
          } else if widget-number == 2 {
            let a = measure(info-box).width
            let b = measure(score-box).width
            if a + b > size.width {
              (1, center + horizon)
            } else {
              (2, (left + horizon, right + horizon))
            }
          }
        }

        align(center, grid(
          columns: columns,
          align: alignment,
          column-gutter: widget-column-gap,
          row-gutter: widget-row-gap,
          ..display-widgets
        ))
      })

      v(widget-spacing-below)
    }

    //
    // TITLE
    //

    if title != none {
      let styled-title = if title-default-styling {
        underline[*#title*]
      } else [#title]
      align(center, text(title-size, styled-title))
    }

    //
    // REST OF THE DOCUMENT
    //

    doc
  }
}
