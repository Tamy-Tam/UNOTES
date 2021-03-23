import EditorJs from '@editorjs/editorjs';
import Header from '@editorjs/header';
import SimpleImage from '@editorjs/simple-image';
import Link from '@editorjs/link';
import Raw from '@editorjs/raw';
import Image from '@editorjs/image';
import Checklist from '@editorjs/checklist';
import List from '@editorjs/list';
import Embed from '@editorjs/embed';
import Quote from '@editorjs/quote';
const CodeTool = require('@editorjs/code');

const initEditor = () => {
  const editorDiv = document.querySelector('#editorjs')
  if (editorDiv) {
    let editorContent = JSON.parse(editorDiv.dataset.content)?.blocks;
    editorContent ||=
    [
    {
      type: "header",
      data: {
        text: "Editor.js",
        level: 2
      }
    }, {
      type: 'paragraph',
      data: {
        text: 'Hey. Meet the new Editor. On this page you can see it in action — try to edit this text. Source code of the page contains the example of connection and configuration.'
      }
    }, {
      type: 'list',
      data: {
        items: [
        'It is a block-styled editor',
        'It returns clean data output in JSON',
        'Designed to be extendable and pluggable with a simple API',
         ],
         style: 'unordered'
       }
     }, {
      type: 'paragraph',
      data: {
        text: 'Workspace in classic editors is made of a single contenteditable element, used to create different HTML markups. Editor.js <mark class=\"cdx-marker\">workspace consists of separate Blocks: paragraphs, headings, images, lists, quotes, etc</mark>. Each of them is an independent contenteditable element (or more complex structure) provided by Plugin and united by Editor\'s Core.'
        }
      }, {
      "type" : "code",
      "data" : {
        "code": "body {\n font-size: 14px;\n line-height: 16px;\n}, To open a Code panel press:'CMD+SHIFT+C'",
       }
      }
    ]

    const editor = new EditorJs({
      /**
       * Enable/Disable the read only mode
       */
      readOnly: false,
      /**
       * Wrapper of Editor
       */
      holder: 'editorjs',
      LogLevel: "ERROR",
      /**
       * Common Inline Toolbar settings
       * - if true (or not specified), the order from 'tool' property will be used
       * - if an array of tool names, this order will be used
       */
      // inlineToolbar: ['link', 'marker', 'bold', 'italic'],
      // inlineToolbar: true,

      /**
       * Tools list
       */
      tools: {

        code: {
          class:  CodeTool,
          inlineToolbar: true,
          shortcut: 'CMD+SHIFT+C'
        },

        /**
         * Each Tool is a Plugin. Pass them via 'class' option with necessary settings {@link docs/tools.md}
         */
        header: {
          class: Header,
          // inlineToolbar: ['marker', 'link'],
          config: {
            placeholder: 'Header'
          },
          shortcut: 'CMD+SHIFT+H'
        },

        /**
         * Or pass class directly without any configuration
         */
        list: {
          class: List,
          inlineToolbar: true,
          shortcut: 'CMD+SHIFT+L'
        },

        checklist: {
          class: Checklist,
          inlineToolbar: true,
        },

        quote: {
          class: Quote,
          inlineToolbar: true,
          config: {
            quotePlaceholder: 'Enter a quote',
            captionPlaceholder: 'Quote\'s author',
          },
          shortcut: 'CMD+SHIFT+O'
        },
      },
      /**
       * Initial Editor data
       */
      data: {
        blocks: editorContent
      },

      onChange: function() {
        console.log('something changed');
      }
    });

    editor.isReady
    .then(() => {
      console.log('Editor.js is ready to work!');

      const saveButton = document.querySelector('#saveButton');
      saveButton.addEventListener('click', function() {
        editor.save().then((outputData) => {
          console.log('Article data: ', outputData);
          const data = new FormData();
          data.append('note[json_content]',JSON.stringify(outputData));
          fetch(window.location.pathname +'/save_content',{
          method:"PATCH",
          body:data
          })

          .then(response => response.json())
          .then(data => console.log(data))
          .catch((error) => {
            console.log('request failed: ', error);
          });

        // const outputContent = document.querySelector('#output');
            // outputContent.innerHTML =JSON.stringify(outputData);
        }).catch((error) => {
          console.log('Saving failed: ', error);
        });

      })
    })
    .catch((reason) => {
      console.log(`Editor.js initialization failed because of ${reason}`)
    });
  };
};

export { initEditor };
