import time
from appium.webdriver.common.mobileby import MobileBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from pageobjects.basepage import BasePage
#from pageobjects.bc_wallet.home import HomePage


# These classes can inherit from a BasePage to do common setup and functions
class InformationSentSuccessfullyPage(BasePage):
    """Proof Information sent successfully page object"""

    # Locators
    on_this_page_text_locator = "Information sent successfully"
    done_locator = "Done"

    def on_this_page(self):
        #print(self.driver.page_source)
        return super().on_this_page(self.on_this_page_text_locator)

    def select_done(self):
        if self.on_this_page():
            self.find_by_accessibility_id(self.done_locator).click()
            from pageobjects.bc_wallet.home import HomePage
            return HomePage(self.driver)
        else:
            raise Exception(f"App not on the {type(self)} page")

