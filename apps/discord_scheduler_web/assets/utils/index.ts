import moment from "moment-timezone";

function zeroFill(number: number, width: number) {
    width -= number.toString().length
    const numberToString = number.toString();

    if (width > 0) {
        return new Array(width + (/\./.test(numberToString) ? 2 : 1)).join('0') + number
    }

    return number + ""
}

function convertTimeToInteger(time: string): [number, number] {
    const [hour, min] = time.split(":");
    const hourNumber = parseInt(hour);
    const minNumber = parseInt(min);

    return [hourNumber, minNumber]
}

function getMomentTime(date: string): string {
    return moment(date).format("HH:mm")
}

function getMomentDate(date: string): string {
    return moment(date).toString();
}

function getFormatedMomentDate(date: string): string {
    return moment(date)
        .tz("Asia/Tokyo")
        .format("MM月DD日 HH:mm");
}
export { zeroFill, convertTimeToInteger, getMomentTime, getFormatedMomentDate, getMomentDate }