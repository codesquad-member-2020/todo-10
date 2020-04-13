interface IContent {
    id: string;
    title: string;
    content: string;
}
interface ITodoViewTemplate {
    id: string;
    title: string;
    content: string;
    cards: [];
    sections: [];
}

interface ICardOption {
    dragTarget: Node | HTMLElement | null;
    targetHeight: number | null;
    toTarget: Node | HTMLElement | null;
    toTargetWrap: Node | HTMLElement | null;
    prevColumn: Node | HTMLElement | null;
    currColumn: Node | HTMLElement | null;
}

interface IOnClickSubmit {
    event: Event;
    parentClassName: string;
    type: string;
    callback: Function;
}

interface ITodoEventList {
    click: Function;
    submit: Function;
    input: Function;
}

interface ITodoAppEventList extends ITodoEventList {
    dblclick: Function;
    dragstart: Function;
    dragover: Function;
    dragenter: Function;
    dragend: Function;
}

export { ITodoViewTemplate, ICardOption, IOnClickSubmit, ITodoEventList, ITodoAppEventList };
