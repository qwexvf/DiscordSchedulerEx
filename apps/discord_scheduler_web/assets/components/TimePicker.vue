<template>
  <div class="form-group">
    <b-form-group id="input-group-2" label="日付" label-for="datetime">
      <b-form-input :value="defaultDate" @input="updateDateValue" id="datetime"></b-form-input>
    </b-form-group>

    <select :value="defaultTime" @input="updateTimeValue" class="form-control" id="time" size="10">
      <option :key="index" v-for="(time, index) in generateTime()" :value="time">{{ time }}</option>
    </select>
  </div>
</template>

<script lang="ts">
import { zeroFill } from "../utils";
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css";
import { Japanese } from "flatpickr/dist/l10n/ja.js";

import { Component, Vue, Prop } from "nuxt-property-decorator";
import { Instance } from "flatpickr/dist/types/instance";

@Component
export default class TimePicker extends Vue {
  @Prop()
  defaultDate!: string
  
  @Prop()
  defaultTime!: string

  private defaultSkipLength: string[] = [":00", ":15", ":30", ":45"];
  private flatpickr: any = null;

  zeroFill(value: number, number: number) {
    return zeroFill(value, number);
  }

  mounted(): void {
    this.generateTime();

    this.flatpickr = flatpickr("#datetime", {
      allowInput: true,
      locale: Japanese,
      altInput: true,
      altFormat: "Y-m-d "
    });

    this.flatpickr.redraw();
  }

  updateTimeValue(e: any): void {
    this.$emit("update:time", e.target.value);
  }

  updateDateValue(value: string): void {
    this.$emit("update:reservation_date", value);
  }

  generateTime(): string[] {
    let timeArray: string[] = [];

    for (let i = 0; i <= 23; i++) {
      for (let j = 0; j < this.defaultSkipLength.length; j++) {
        timeArray.push(this.zeroFill(i, 2) + this.defaultSkipLength[j]);
      }
    }

    return timeArray;
  }
}
</script>