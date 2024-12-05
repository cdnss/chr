// index.js
const chromium = require('chrome-aws-lambda');
const puppeteer = require('puppeteer-core');
async function handler(event, context){
    const browser = await puppeteer.launch({
        args: chromium.args,
        defaultViewport: chromium.defaultViewport,
        executablePath: await chromium.executablePath,
        headless: chromium.headless,
    });

    const page = await browser.newPage();
    await page.goto('https://doujindesu.tv');

    // Your Puppeteer automation here, e.g.,
    const title = await page.title();

    await browser.close();

    return {
        statusCode: 200,
        body: JSON.stringify({ title }),
    };
};

export default handler;

/*const chromium = require('chrome-aws-lambda')
const puppeteer = require('puppeteer-core')

exports.handler = async (event, context) => {
  let theTitle = null
  let browser = null
  console.log('spawning chrome headless')
  try {
    const executablePath = await chromium.executablePath

    // setup
    browser = await puppeteer.launch({
      args: chromium.args,
      executablePath: executablePath,
      headless: chromium.headless,
    })

    // Do stuff with headless chrome
    const page = await browser.newPage()
    const targetUrl = 'https://davidwells.io'

    // Goto page and then do stuff
    await page.goto(targetUrl, {
      waitUntil: ['domcontentloaded', 'networkidle0']
    })

    await page.waitForSelector('#phenomic')

    theTitle = await page.title()

    console.log('done on page', theTitle)
  } catch (error) {
    console.log('error', error)
    return {
      statusCode: 500,
      body: JSON.stringify({
        error: error
      })
    }
  } finally {
    // close browser
    if (browser !== null) {
      await browser.close()
    }
  }

  return {
    statusCode: 200,
    body: JSON.stringify({
      title: theTitle,
    })
  }
}
*/
