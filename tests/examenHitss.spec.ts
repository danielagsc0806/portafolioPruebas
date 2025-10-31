import { test, expect} from '@playwright/test';

test('Mercado Libre', async ({ page }) => {
  // Go to https://www.mercadolibre.com/
  await page.goto('https://www.mercadolibre.com');
  await expect(page).toHaveTitle(/Mercado Libre - Envíos Gratis en el día/);
  // Click México
  await page.click('text=México');
  await expect(page).toHaveURL('https://www.mercadolibre.com.mx/#from=homecom');
  //search for playstation 5
  await page.locator('input#cb1-edit').fill('playstation 5');
  await page.keyboard.press('Enter');
  //await expect(page.locator('//h1[contains(text(), "Playstation 5")]')).toBeVisible();
  //filter by new condition
  await page.locator('//h3[contains(text(), "Condición")]').scrollIntoViewIfNeeded();
  await page.locator('//span[contains(text(), "Nuevo")]').click();
  //await expect(page.locator('//div[contains(@class, "andes-tag__label") and contains(text(), "Nuevo")]')).toBeVisible();
  //the filter for ubication is not disponible
  //order by price from highest to lowest
  //view the first 5 items
  //await expect(page.locator('//ol[contains(@class, \'ui-search-layout\')]')).toBeVisible();
  const titles= await page.locator('//ol[contains(@class, \'ui-search-layout\')]//li//h3').allInnerTexts();
  console.log('the total numbers of results is: ', titles.length);
  const firstFive = titles.slice(0, 5);
  for (let title of firstFive) {
    console.log('the title is:', title);
  } 
});
