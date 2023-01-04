import prompt from '@ohos.prompt';
import router from '@ohos.router';
import CommonStants from '../common/constants/CommonConstants'

@Extend(TextInput) function inputStyle () {
    .placeholderColor($r('app.color.placeholder_color'))
    .height($r('app.float.login_input_height'))
    .fontSize($r('app.float.big_text_size'))
    .backgroundColor($r('app.color.background'))
    .width(CommonStants.FULL_PARENT)
    .padding({
      left: CommonStants.INPUT_PADDING_LEFT
    })
    .margin({
      top: $r('app.float.input_margin_top')
    })
}

@Extend(Line) function lineStyle() {
  .width(CommonStants.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Extend(Text) function blueTextStyle() {
  .fontColor($r('app.color.login_blue_text_color'))
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}


@Entry
@Component
struct LoginPage {
  @State account: string = ''
  @State password: string =''
  @State isShowProgress: boolean = false;
  private timeoutId = null;

  @Builder imageButton(src: Resource) {
    Button({type: ButtonType.Circle, stateEffect: true}) {
      Image(src)
    }
      .height($r('app.float.other_login_image_size'))
      .width($r('app.float.other_login_image_size'))
      .backgroundColor($r('app.color.background'))
  }

  login() {
    console.log('[LoginPage] >> login')
  }


  build() {
    Column() {
      Image($r('app.media.logo'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin({
          top:$r('app.float.logo_margin_top'),
          bottom: $r('app.float.logo_margin_bottom')
        })

      Text($r('app.string.login_page'))
        .fontSize($r('app.float.page_title_text_size'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.title_text_color'))
//        .margin({
//          top: $r('app.float.logo_margin_top')
//        })
      Text($r('app.string.login_more'))
        .fontSize($r('app.float.normal_text_size'))
        .fontColor($r('app.color.login_more_text_color'))
        .margin({
          bottom: $r('app.float.login_more_margin_bottom'),
          top: $r('app.float.login_more_margin_top')
        })

      TextInput({placeholder: $r('app.string.account')})
        .maxLength(CommonStants.INPUt_ACCOUNT_LENGTH)
        .type(InputType.Number)
        .inputStyle()
        .onChange((value: string) => {
          this.account = value
          console.log('[LoginPage] >> account:',value)
        })
      Line().lineStyle()

      TextInput({placeholder: $r('app.string.password')})
        .maxLength(CommonStants.INPUT_PASSWORD_LENGTH)
        .type(InputType.Password)
        .inputStyle()
        .onChange((pwd: string) => {
            this.password = pwd;
        })
      Line().lineStyle()

      Row(){
        Text($r('app.string.message_login')).blueTextStyle()
        Text($r('app.string.forgot_password')).blueTextStyle()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonStants.FULL_PARENT)
      .margin({
        top: $r('app.float.forgot_margin_top')
      })

      Button($r('app.string.login'),{type: ButtonType.Capsule})
        .width(CommonStants.BUTTON_WIDTH)
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.login_button_color'))
        .margin({
          top: $r('app.float.login_button_margin_top'),
          bottom: $r('app.float.login_button_margin_bottom')
        })
        .onClick(() =>{
          this.login();
        })

      Text($r('app.string.register_account'))
        .fontColor($r('app.color.login_blue_text_color'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)

      if (this.isShowProgress) {
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({
            top: $r('app.float.login_progress_margin_top')
          })
      }

      Blank()
      Text($r('app.string.other_login_method'))
        .fontColor($r('app.color.other_login_text_color'))
        .fontSize($r('app.float.little_text_size'))
        .fontWeight(FontWeight.Medium)
        .margin({
          top: $r('app.float.other_login_margin_top'),
          bottom: $r('app.float.other_login_margin_bottom')
        })
      Row({space: CommonStants.LOGIN_METHODS_SPACE}) {
        this.imageButton($r('app.media.login_method1'))
        this.imageButton($r('app.media.login_method2'))
        this.imageButton($r('app.media.login_method3'))
      }
    }
    .backgroundColor($r('app.color.background')) //
    .height(CommonStants.FULL_PARENT)
    .width(CommonStants.FULL_PARENT)
    .padding({
      left: $r('app.float.page_padding_hor'),
      right: $r('app.float.page_padding_hor'),
      bottom: $r('app.float.login_button_margin_bottom')
    })
  }
}