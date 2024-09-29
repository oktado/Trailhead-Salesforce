import { LightningElement } from "lwc";

export default class CalculateDay extends LightningElement {
  DateValue = new Date();
  SelectedDate;
  AddDay;

  handleSelectedDate(event) {
    this.SelectedDate = event.target.value;
  }
  handleAddDay(event) {
    this.AddDay = event.target.value;
  }

  handleCalculatingDay() {
    console.log(this.SelectedDate);
    console.log(this.AddDay);
    if (this.SelectedDate != null && this.AddDay != null) {
      let date = new Date(this.SelectedDate);
      this.AddDay = parseInt(this.AddDay);
      this.DateValue = date.setDate(date.getDate() + parseInt(this.AddDay));
    }
  }
}