.. _contributing_docs:

Contributing documentation
==========================

|docs|

.. |docs| image:: https://readthedocs.org/projects/docs/badge/?version=latest
   :alt: Documentation Status
   :scale: 100%
   :target: https://template-formula.readthedocs.io/en/latest/?badge=latest

Toolchain
^^^^^^^^^

The documentation for this formula is written in
`reStructuredText <https://en.wikipedia.org/wiki/ReStructuredText>`_
(also known as RST, ReST, or reST).
It is built by
`Sphinx <https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)>`_
and hosted on
`Read the Docs <https://en.wikipedia.org/wiki/Read_the_Docs>`_.

Adding a new page
^^^^^^^^^^^^^^^^^

Adding a new page involves two steps:

#. Use the
   :ref:`provided page template <saltstack_formulas_rst_page_template>`
   to create a new page.
#. Add the page name under the ``toctree`` list in ``index.rst``.

   a. Do not just append it to the list.
   #. Select the best place where it fits within the overall documentation.

SaltStack-Formulas' RST page template
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. _saltstack_formulas_rst_page_template

Use the following template when creating a new page.
This ensures consistency across the documentation for this formula.
The heading symbols have been selected in accordance to the output rendered by the
`Markdown to reStructuredText converter <https://github.com/miyakogi/m2r#restrictions>`_
we are using for some of the pages of this documentation.

.. code-block:: rst

   .. _template:

   [Page title]
   ============

   [Introductory paragraph]

   .. contents:: **Table of Contents**

   [Heading 2]
   -----------

   [Heading 3]
   ^^^^^^^^^^^

   [Heading 4]
   ~~~~~~~~~~~

   [Heading 5]
   """""""""""

   [Heading 6]
   ###########

#. The first line is an anchor that can be used to link back to (the top of)
   this file.

   a. Change this to be the lowercase version of the file name.
   #. Do not include the ``.rst`` file extension.
   #. Use hyphens (``-``) instead of spaces or non-letter characters.

#. Change the ``[Page title]`` accordingly, matching the same number of equals
   signs (``=``) underneath.
#. Change the ``[Introductory paragraph]`` to be a short summary of the page
   content.
   Use no more than three paragraphs for this.
#. Leave the ``..contents:: **Table of Contents**`` line as it is.
#. Use the remaining headings as required to break up the page content.

   a. You will rarely need to use beyond ``[Heading 4]``.
   #. Again, no single heading should have more than about three paragraphs of
      content before the next heading or sub-heading is used.

Obviously, it is not necessary to follow the steps in the order above.
For example, it is usually easier to write the ``[Introductory paragraph]``
at the end.

