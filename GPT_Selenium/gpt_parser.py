import os
import win32gui
import win32con
import time
import random
from time import sleep
from selenium.webdriver.remote.webdriver import By
import undetected_chromedriver as uc
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException, TimeoutException

class gptParser:

    OPENAI_URL = "https://chat.openai.com/"

    def __init__(self,
                 driver,
                 gpt_url: str = 'https://chat.openai.com/'):
        """ ChatGPT parser
        Args:
            driver_path (str, optional): The path of the chromedriver.
            gpt_url (str, optional): The url of ChatGPT.
        """
        # Start a webdriver instance and open ChatGPT
        self.driver = driver
        self.driver.get(gpt_url)

    @staticmethod
    def get_driver(driver_path: str = None):
        return uc.Chrome() if driver_path is None else uc.Chrome(driver_path)

    def __call__(self, query: str):
        # Find the input field and send a question
        input_field = self.driver.find_element(
            By.TAG_NAME, 'textarea')
        input_field.send_keys(query)
        input_field.send_keys(Keys.RETURN)

    def read_respond(self):
        try:
            response = self.driver.find_elements(By.TAG_NAME, 'p')[-2].text
            return response
        except:
            return None
        
    def auto_login(self) -> None:
        self.driver.find_element(By.CSS_SELECTOR, "[data-testid='login-button']").click()
        self.driver.implicitly_wait(10)
        username_field=self.driver.find_element(By.NAME, "username")
        username_field.send_keys("账号")#账号
        self.driver.find_element(By.CLASS_NAME,"_button-login-id").click()
        # continue_button=self.driver.find_element(By.NAME,"action")
        # continue_button.click()
        #self.driver.find_element_by_xpath("//div/main/section/div/div/div/div[1]/div/form/div[2]/button")

        self.driver.implicitly_wait(10)
        password_field=self.driver.find_element(By.NAME, "password")
        password_field.send_keys("密码")#密码
        self.driver.implicitly_wait(10)
        self.driver.find_element(By.CLASS_NAME,"_button-login-password").click()
        # continue_button=self.driver.find_element(By.NAME,"action")
        # continue_button.click()
        #self.driver.find_element_by_xpath("//div[1]/main/section/div/div/div/form/div[3]/button")


    def set_gpt_model(self, model_version: str) -> None:
        """Set GPT model.

        Args:
            model_version (str): GPT model version (GPT-3.5 or GPT-4)
        """
        if model_version not in ["GPT-3.5", "GPT-4"]:
            msg = "model_version must be GPT-3.5 or GPT-4"
            raise ValueError(msg)
        self.driver.find_element(By.XPATH, f"//button[contains(., '{model_version}')]").click()

    def set_gpts(self) -> None:
        self.driver.find_element(By.LINK_TEXT,"Verilog Auto Debug").click()

    def upload_files(self,docs:str) -> None:
        self.driver.find_element(By.CSS_SELECTOR, "[aria-label='Attach files']").click()    
        time.sleep(random.uniform(1, 5))
        # upload = self.driver.find_element_by_id('file')
        # upload.send_keys('d:\\test\\multiply.v''d:\\test\\testbench.v''d:\\test\\vcompile.txt')  # send_keys
       
        # win32gui
        dialog = win32gui.FindWindow('#32770', '打开')  # 对话框
        ComboBoxEx32 = win32gui.FindWindowEx(dialog, 0, 'ComboBoxEx32', None)
        ComboBox = win32gui.FindWindowEx(ComboBoxEx32, 0, 'ComboBox', None)
        Edit = win32gui.FindWindowEx(ComboBox, 0, 'Edit', None)  # 上面三句依次寻找对象，直到找到输入框Edit对象的句柄
        button = win32gui.FindWindowEx(dialog, 0, 'Button', None)  # 确定按钮Button

        win32gui.SendMessage(Edit, win32con.WM_SETTEXT, None, docs)  # 往输入框输入绝对地址
        win32gui.SendMessage(dialog, win32con.WM_COMMAND, 1, button)  # 按button

        sleep(10)
        self.driver.find_element(By.CSS_SELECTOR, "[data-testid='send-button']").click()
        

    def send_prompt(self, prompt: str) -> None:
        """Send prompt.

        Args:
            prompt (str): Send prompt to ChatGPT
        """
        self.driver.implicitly_wait(10)
        textarea = self.driver.find_element(By.CSS_SELECTOR, "textarea")
        textarea.clear()
        textarea.send_keys(prompt)
        time.sleep(random.uniform(1, 5))
        self.driver.find_element(By.CSS_SELECTOR, "button.absolute").click()

    # temporarily abolishing
    # def get_user_prompt(self):
    #     user_elements = self.driver.find_elements(
    #         By.XPATH,
    #         '//div[contains(@class, "group w-full text-gray-800 dark:text-gray-100 border-b border-black/10 dark:border-gray-900/50 dark:bg-gray-800")]',
    #     )
    #     return [user_element.text for user_element in user_elements]

    def get_gpt_response(self, timeout: int = 60) -> list[str]:
        """Get GPT response.

        Args:
            timeout (int, optional): Timeout. Defaults to 60.
        """
        # Temporarily disable implicit wait
        self.driver.implicitly_wait(0)

        try:
            # Check if the element that is being output exists
            WebDriverWait(self.driver, 1).until(
                EC.presence_of_element_located((By.XPATH, '//div[contains(@class, "result-streaming")]')),
            )

            # If it exists, wait until the output is finished
            WebDriverWait(self.driver, timeout).until(
                EC.invisibility_of_element_located((By.XPATH, '//div[contains(@class, "result-streaming")]')),
            )
        except TimeoutException:
            # If the element doesn't exist, continue to get the text
            pass
        finally:
            # Re-enable implicit wait
            self.driver.implicitly_wait(10)

        # Get the element after the output is finished
        gpt_elements = self.driver.find_elements(
            By.XPATH,
            '//div[contains(@class, "markdown")]',
        )
        return [gpt_element.text for gpt_element in gpt_elements]

    # def new_conversation(self) -> None:
    #     """Create new conversation."""
    #     try:
    #         self.driver.find_element(By.LINK_TEXT, "New chat").click()
    #     except ElementClickInterceptedException:
    #         self.driver.find_element(By.LINK_TEXT, "Clear chat").click()

    # def resume_conversation(self, chatid: str) -> None:
    #     """Resume conversation.

    #     Args:
    #         chatid (str): chatid
    #     """
    #     resume_chat_page = gptParser.OPENAI_URL + f"/c/{chatid}"
    #     self.driver.get(resume_chat_page)
    #     time.sleep(1)
    #     if self.driver.current_url != resume_chat_page:
    #         msg = "Unable to load conversation page. Check if the chatid is correct."
    #         raise ValueError(msg)


    # def new_chat(self):
    #     """Open a new chat"""
    #     self.driver.find_element(By.XPATH, '//a[text()="New chat"]').click()

    def quit(self):
        self.driver.quit()